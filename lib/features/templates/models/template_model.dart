enum TemplateStatus { ready, comingSoon }

class TemplateModel {
  const TemplateModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.thumbnailUrl,
    required this.previewVideoUrl,
    required this.duration,
    required this.tags,
    required this.isPremium,
    required this.status,
  });

  final String id;
  final String name;
  final String description;
  final String category;
  final String thumbnailUrl;
  final String previewVideoUrl;
  final Duration duration;
  final List<String> tags;
  final bool isPremium;
  final TemplateStatus status;

  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      previewVideoUrl: json['previewVideoUrl'] as String? ?? '',
      duration: Duration(seconds: json['durationSeconds'] as int? ?? 30),
      tags: (json['tags'] as List<dynamic>? ?? const [])
          .map((tag) => tag.toString())
          .toList(growable: false),
      isPremium: json['isPremium'] as bool? ?? false,
      status: (json['status'] as String?) == 'ready'
          ? TemplateStatus.ready
          : TemplateStatus.comingSoon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'thumbnailUrl': thumbnailUrl,
      'previewVideoUrl': previewVideoUrl,
      'durationSeconds': duration.inSeconds,
      'tags': tags,
      'isPremium': isPremium,
      'status': status == TemplateStatus.ready ? 'ready' : 'coming_soon',
    };
  }
}
