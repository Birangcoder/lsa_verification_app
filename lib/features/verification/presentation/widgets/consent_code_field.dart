import 'package:flutter/material.dart';

class ConsentCodeField extends StatelessWidget {
  final TextEditingController controller;

  const ConsentCodeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Parent Consent Code',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter parent consent code',
          ),
        ),
      ],
    );
  }
}
