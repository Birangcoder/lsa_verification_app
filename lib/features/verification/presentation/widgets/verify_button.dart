import 'package:flutter/material.dart';

class VerifyButton extends StatelessWidget {
  final bool enabled;
  final bool processing;
  final VoidCallback onPressed;

  const VerifyButton({
    super.key,
    required this.enabled,
    required this.processing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: enabled && !processing
            ? onPressed
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          child: processing
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : const Text('Verify & Submit'),
        ),
      ),
    );
  }
}