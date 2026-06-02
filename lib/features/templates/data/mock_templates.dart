import '../models/template_model.dart';

List<TemplateModel> get mockTemplates => const [
      TemplateModel(
        id: 'hustle-motivation',
        name: 'Hustle Motivation',
        description:
            'Quote bold + cinematic B-roll. Cocok untuk konten produktivitas.',
        category: 'Motivation',
        thumbnailUrl: 'https://placehold.co/600x900/1e293b/ffffff?text=Hustle',
        previewVideoUrl: '',
        duration: Duration(seconds: 30),
        tags: ['vertical', '1080p', 'quotes'],
        isPremium: false,
        status: TemplateStatus.comingSoon,
      ),
      TemplateModel(
        id: 'aesthetic-lifestyle',
        name: 'Aesthetic Lifestyle',
        description:
            'Slow zoom, soft color, dan scene pendek untuk lifestyle vlog.',
        category: 'Lifestyle',
        thumbnailUrl:
            'https://placehold.co/600x900/f7d9c4/0b0c10?text=Aesthetic',
        previewVideoUrl: '',
        duration: Duration(seconds: 30),
        tags: ['vertical', 'soft', 'lifestyle'],
        isPremium: false,
        status: TemplateStatus.comingSoon,
      ),
      TemplateModel(
        id: 'tutorial-step-by-step',
        name: 'Tutorial Step By Step',
        description:
            'Format edukasi 5 langkah dengan counter dan progress indicator.',
        category: 'Tutorial',
        thumbnailUrl:
            'https://placehold.co/600x900/0f172a/d4af37?text=Tutorial',
        previewVideoUrl: '',
        duration: Duration(seconds: 30),
        tags: ['vertical', 'education', 'steps'],
        isPremium: false,
        status: TemplateStatus.comingSoon,
      ),
      TemplateModel(
        id: 'curhat-story',
        name: 'Curhat Story',
        description:
            'Story text reveal word-by-word untuk narasi personal dan emotional hook.',
        category: 'Story',
        thumbnailUrl: 'https://placehold.co/600x900/1e3a8a/ffffff?text=Curhat',
        previewVideoUrl: '',
        duration: Duration(seconds: 30),
        tags: ['vertical', 'story', 'word-reveal'],
        isPremium: false,
        status: TemplateStatus.comingSoon,
      ),
      TemplateModel(
        id: 'quote-compilation',
        name: 'Quote Compilation',
        description:
            '5 quote cards dengan transisi cross-fade untuk konten motivasi cepat.',
        category: 'Quote',
        thumbnailUrl: 'https://placehold.co/600x900/050608/d4af37?text=Quotes',
        previewVideoUrl: '',
        duration: Duration(seconds: 30),
        tags: ['vertical', 'quotes', 'carousel'],
        isPremium: false,
        status: TemplateStatus.comingSoon,
      ),
    ];
