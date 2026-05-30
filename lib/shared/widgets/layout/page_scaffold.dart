import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../navigation/app_appbar.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions = const [],
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.safeArea = true,
    this.scrollable = false,
    this.floatingActionButton,
  });

  final Widget body;
  final String? title;
  final List<Widget> actions;
  final EdgeInsetsGeometry padding;
  final bool safeArea;
  final bool scrollable;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(padding: padding, child: body);
    if (scrollable) {
      content = SingleChildScrollView(child: content);
    }
    if (safeArea) {
      content = SafeArea(child: content);
    }

    return Scaffold(
      backgroundColor: AppColors.obsidian,
      appBar: title == null ? null : AppAppBar(title: title!, actions: actions),
      body: content,
      floatingActionButton: floatingActionButton,
    );
  }
}
