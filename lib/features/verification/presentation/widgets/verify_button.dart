import 'package:flutter/material.dart';

class VerifyButton extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback onPressed;

  const VerifyButton({
    super.key,
    required this.isProcessing,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: isProcessing ? null : onPressed,
        child: isProcessing
            ? const CircularProgressIndicator()
            : const Text('Verify & Submit'),
      ),
    );
  }
}
