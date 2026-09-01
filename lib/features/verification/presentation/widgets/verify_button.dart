import 'package:flutter/material.dart';

class VerifyButton extends StatelessWidget {
  const VerifyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Submission logic will be added later.
        },
        child: const Text('Verify & Submit'),
      ),
    );
  }
}
