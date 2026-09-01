import 'package:flutter/material.dart';

class VerificationHeader extends StatelessWidget {
  const VerificationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LSA Onboarding Gate',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 6),
        Text(
          'HabotConnect Data Compliance',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}