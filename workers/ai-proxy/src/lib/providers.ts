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

function assertPrompt(body: LlmRequest) {
  if (!body.prompt && !body.messages?.length) {
    throw new Response(JSON.stringify({
      error: { code: 'invalid_request', message: 'Request must include prompt or messages.' },
    }), { status: 400, headers: { 'Content-Type': 'application/json' } });
  }
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
