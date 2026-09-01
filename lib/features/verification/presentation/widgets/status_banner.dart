import 'package:flutter/material.dart';

import '../../../../core/enums/verification_status.dart';

class StatusBanner extends StatelessWidget {
  final VerificationStatus status;
  final String message;

  const StatusBanner({super.key, required this.status, required this.message});

  String get statusText {
    switch (status) {
      case VerificationStatus.idle:
        return 'Idle';

      case VerificationStatus.processing:
        return 'Processing';

      case VerificationStatus.success:
        return 'Success';

      case VerificationStatus.error:
        return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Status: $statusText',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(message),
        ],
      ),
    );
  }
}
