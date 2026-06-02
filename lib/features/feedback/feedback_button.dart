import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/env/env.dart';
import 'feedback_category_sheet.dart';

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (Env.feedbackWhatsappNumber.isEmpty) {
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
    final route = _currentRoute(context);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => FeedbackCategorySheet(currentRoute: route),
    );
  }

  String? _currentRoute(BuildContext context) {
    try {
      final state = GoRouterState.of(context);
      return state.fullPath ?? state.uri.path;
    } catch (_) {
      return ModalRoute.of(context)?.settings.name;
    }
  }
}
