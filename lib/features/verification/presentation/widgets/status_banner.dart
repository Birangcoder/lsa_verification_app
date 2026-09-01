import 'package:flutter/material.dart';

import '../../../../core/enums/verification_status.dart';

class StatusBanner extends StatelessWidget {
  final VerificationStatus status;

  const StatusBanner({super.key, required this.status});

  String get statusText {
    switch (status) {
      case VerificationStatus.idle:
        return 'Idle';

      case VerificationStatus.processing:
        return 'Processing...';

      case VerificationStatus.success:
        return 'Success';
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
      child: Text(
        'Status: $statusText',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
