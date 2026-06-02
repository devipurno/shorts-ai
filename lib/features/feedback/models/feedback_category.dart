enum FeedbackCategory {
  bug('Bug', '🐛'),
  feature('Saran Fitur', '✨'),
  praise('Apresiasi', '💙');

  const FeedbackCategory(this.label, this.emoji);

  final String label;
  final String emoji;
}
