import 'package:flutter/material.dart';

import 'text_input.dart';

class AppPasswordInput extends StatefulWidget {
  const AppPasswordInput({
    super.key,
    this.controller,
    this.label = 'Password',
    this.hint,
    this.errorText,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  State<AppPasswordInput> createState() => _AppPasswordInputState();
}

class _AppPasswordInputState extends State<AppPasswordInput> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return AppTextInput(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      errorText: widget.errorText,
      obscureText: _obscure,
      onChanged: widget.onChanged,
      suffixIcon: IconButton(
        tooltip: _obscure ? 'Show password' : 'Hide password',
        icon: Icon(_obscure
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}
