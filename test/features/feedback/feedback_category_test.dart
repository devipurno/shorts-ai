import 'package:flutter_test/flutter_test.dart';
import 'package:shorts_ai/features/feedback/models/feedback_category.dart';

void main() {
  test('all feedback categories are defined with unique labels and emoji', () {
    expect(FeedbackCategory.values, hasLength(3));
    expect(FeedbackCategory.values, contains(FeedbackCategory.bug));
    expect(FeedbackCategory.values, contains(FeedbackCategory.feature));
    expect(FeedbackCategory.values, contains(FeedbackCategory.praise));

    final labels = FeedbackCategory.values.map((category) => category.label);
    final emojis = FeedbackCategory.values.map((category) => category.emoji);

    expect(labels.toSet(), hasLength(3));
    expect(emojis.toSet(), hasLength(3));
    expect(FeedbackCategory.bug.label, 'Bug');
    expect(FeedbackCategory.feature.label, 'Saran Fitur');
    expect(FeedbackCategory.praise.label, 'Apresiasi');
  });
}
