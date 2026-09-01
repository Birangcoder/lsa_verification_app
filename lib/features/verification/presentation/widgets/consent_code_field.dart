import 'package:flutter/material.dart';

class ConsentCodeField extends StatelessWidget {
  const ConsentCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Parent Consent Code',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter parent consent code',
          ),
        ),
      ],
    );
  }
}
