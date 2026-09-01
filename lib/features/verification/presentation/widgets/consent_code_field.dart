import 'package:flutter/material.dart';

class ConsentCodeField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool enabled;
  final VoidCallback onFocus;
  final VoidCallback onChanged;

  const ConsentCodeField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.enabled,
    required this.onFocus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      onTap: onFocus,
      onChanged: (_) => onChanged(),
      decoration: const InputDecoration(
        labelText: 'Parent Consent Code',
        hintText: 'Enter consent code',
        border: OutlineInputBorder(),
      ),
    );
  }
}