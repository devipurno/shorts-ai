type LlmRequest = {
  prompt?: string;
  systemPrompt?: string;
  temperature?: number;
  maxTokens?: number;
  model?: string;
  messages?: Array<{ role: string; content: string }>;
};

type ProxyResponse = {
  text: string;
  provider: string;
  inputTokens?: number;
  outputTokens?: number;
  raw: unknown;
};

function promptMessages(body: LlmRequest) {
  if (body.messages?.length) return body.messages;
  return [
    ...(body.systemPrompt ? [{ role: 'system', content: body.systemPrompt }] : []),
    { role: 'user', content: body.prompt || '' },
  ];
}

async function parseJsonResponse(response: Response): Promise<unknown> {
  const text = await response.text();
  if (!text) return {};
  try {
    return JSON.parse(text) as unknown;
  } catch {
    return { text };
  }
}

const MAX_PROMPT_LENGTH = 100_000;
const MAX_TOKENS_UPPER = 16_384;
const ALLOWED_ROLES = new Set(['system', 'user', 'assistant']);

function badRequest(message: string): never {
  throw new Response(JSON.stringify({
    error: { code: 'invalid_request', message },
  }), { status: 400, headers: { 'Content-Type': 'application/json' } });
}

function validateRequest(body: LlmRequest) {
  if (!body.prompt && !body.messages?.length) {
    badRequest('Request must include prompt or messages.');
  }

  if (body.prompt !== undefined && typeof body.prompt !== 'string') {
    badRequest('prompt must be a string.');
  }
  if (body.prompt && body.prompt.length > MAX_PROMPT_LENGTH) {
    badRequest(`prompt exceeds maximum length of ${MAX_PROMPT_LENGTH} characters.`);
  }

  if (body.systemPrompt !== undefined && typeof body.systemPrompt !== 'string') {
    badRequest('systemPrompt must be a string.');
  }

  if (body.temperature !== undefined) {
    if (typeof body.temperature !== 'number' || body.temperature < 0 || body.temperature > 2) {
      badRequest('temperature must be a number between 0 and 2.');
    }
  }

  if (body.maxTokens !== undefined) {
    if (typeof body.maxTokens !== 'number' || !Number.isInteger(body.maxTokens) || body.maxTokens < 1 || body.maxTokens > MAX_TOKENS_UPPER) {
      badRequest(`maxTokens must be an integer between 1 and ${MAX_TOKENS_UPPER}.`);
    }
  }

  if (body.messages) {
    if (!Array.isArray(body.messages)) {
      badRequest('messages must be an array.');
    }
    for (const msg of body.messages) {
      if (typeof msg.role !== 'string' || !ALLOWED_ROLES.has(msg.role)) {
        badRequest(`Invalid message role "${msg.role}". Allowed: ${[...ALLOWED_ROLES].join(', ')}.`);
      }
      if (typeof msg.content !== 'string') {
        badRequest('Each message must have a string content field.');
      }
    }
  }
}

function assertPrompt(body: LlmRequest) {
  validateRequest(body);
}

export async function proxyGemini(body: LlmRequest, apiKey: string): Promise<ProxyResponse> {
  assertPrompt(body);
  const prompt = [body.systemPrompt, body.prompt].filter(Boolean).join('\n\n');
  const endpoint = `https://generativelanguage.googleapis.com/v1beta/models/${body.model || 'gemini-2.0-flash-exp'}:generateContent?key=${encodeURIComponent(apiKey)}`;
  const response = await fetch(endpoint, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      contents: [{ role: 'user', parts: [{ text: prompt }] }],
      generationConfig: {
        temperature: body.temperature ?? 0.7,
        maxOutputTokens: body.maxTokens ?? 1024,
      },
    }),
  });
  const raw = await parseJsonResponse(response);
  if (!response.ok) {
    throw new Response(JSON.stringify({ error: { code: 'upstream_error', provider: 'gemini', status: response.status, raw } }), { status: 502, headers: { 'Content-Type': 'application/json' } });
  }
  const data = raw as { candidates?: Array<{ content?: { parts?: Array<{ text?: string }> } }> };
  const text = data.candidates?.[0]?.content?.parts?.[0]?.text;
  if (!text) {
    throw new Response(JSON.stringify({ error: { code: 'invalid_upstream_response', provider: 'gemini' } }), { status: 502, headers: { 'Content-Type': 'application/json' } });
  }
  return { text, provider: 'gemini', raw };
}

export async function proxyOpenAiCompatible(options: {
  provider: 'groq' | 'deepseek';
  endpoint: string;
  apiKey: string;
  defaultModel: string;
  body: LlmRequest;
}): Promise<ProxyResponse> {
  assertPrompt(options.body);
  const response = await fetch(options.endpoint, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${options.apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: options.body.model || options.defaultModel,
      temperature: options.body.temperature ?? 0.7,
      max_tokens: options.body.maxTokens ?? 1024,
      messages: promptMessages(options.body),
    }),
  });
  const raw = await parseJsonResponse(response);
  if (!response.ok) {
    throw new Response(JSON.stringify({ error: { code: 'upstream_error', provider: options.provider, status: response.status, raw } }), { status: 502, headers: { 'Content-Type': 'application/json' } });
  }
  const data = raw as {
    choices?: Array<{ message?: { content?: string } }>;
    usage?: { prompt_tokens?: number; completion_tokens?: number };
  };
  const text = data.choices?.[0]?.message?.content;
  if (!text) {
    throw new Response(JSON.stringify({ error: { code: 'invalid_upstream_response', provider: options.provider } }), { status: 502, headers: { 'Content-Type': 'application/json' } });
  }
  return {
    text,
    provider: options.provider,
    inputTokens: data.usage?.prompt_tokens ?? 0,
    outputTokens: data.usage?.completion_tokens ?? 0,
    raw,
  };
}
