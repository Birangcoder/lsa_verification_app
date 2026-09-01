import 'package:flutter/material.dart';

import '../../../../core/enums/verification_status.dart';

class StatusBanner extends StatelessWidget {
  final VerificationStatus status;
  final String message;

  const StatusBanner({
    super.key,
    required this.status,
    required this.message,
  });

  String get statusText {
    switch (status) {
      case VerificationStatus.idle:
        return 'Idle';

      case VerificationStatus.processing:
        return 'Processing';

      case VerificationStatus.success:
        return 'Success';

      case VerificationStatus.quarantined:
        return 'Quarantined (Fail-Closed)';
    }
  }

  IconData get icon {
    switch (status) {
      case VerificationStatus.idle:
        return Icons.info_outline;

      case VerificationStatus.processing:
        return Icons.sync;

      case VerificationStatus.success:
        return Icons.check_circle_outline;

      case VerificationStatus.quarantined:
        return Icons.security;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status: $statusText',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}