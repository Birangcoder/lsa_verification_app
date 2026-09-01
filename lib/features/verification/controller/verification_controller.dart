import 'package:flutter/material.dart';

import '../../../core/enums/verification_status.dart';

class VerificationController {
  final ValueNotifier<VerificationStatus> status =
  ValueNotifier(VerificationStatus.idle);

  final ValueNotifier<String> message =
  ValueNotifier('System is ready for verification.');

  Future<void> submit({
    required String parentConsentCode,
  }) async {
    if (parentConsentCode.trim().isEmpty) {
      status.value = VerificationStatus.error;

      message.value =
      'Parent consent code is required.';

      return;
    }

    // Start processing.
    status.value = VerificationStatus.processing;
    message.value = 'Processing verification...';

    // Temporary delay for testing.
    // Real API logic will be added later.
    await Future.delayed(
      const Duration(seconds: 2),
    );

    // Temporary success.
    status.value = VerificationStatus.success;
    message.value = 'Verification completed successfully.';
  }

  void reset() {
    status.value = VerificationStatus.idle;
    message.value = 'System is ready for verification.';
  }

  void dispose() {
    status.dispose();
    message.dispose();
  }
}