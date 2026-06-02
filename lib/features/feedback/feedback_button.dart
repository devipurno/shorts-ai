import 'package:flutter/material.dart';

import '../../core/env/env.dart';
import 'widgets/feedback_dialog.dart';

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({super.key, this.compact = false});

  final bool compact;

  static bool get isEnabled {
    const dsn = String.fromEnvironment('SENTRY_DSN');
    return dsn.isNotEmpty || Env.sentryDsn != null;
  }

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) {
      return const SizedBox.shrink();
    }

    if (compact) {
      return IconButton(
        key: const Key('feedback-button-compact'),
        icon: const Icon(Icons.feedback_outlined),
        tooltip: 'Kirim feedback',
        onPressed: () => _open(context),
      );
    }

    return ListTile(
      key: const Key('feedback-button'),
      leading: const Icon(Icons.feedback_outlined),
      title: const Text('Kirim Feedback'),
      subtitle: const Text('Bug, saran, atau apresiasi'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _open(context),
    );
  }

  void _open(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const FeedbackDialog(),
    );
  }
}
