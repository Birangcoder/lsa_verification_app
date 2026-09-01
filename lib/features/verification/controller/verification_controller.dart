import 'package:flutter/material.dart';

import '../../../core/enums/verification_status.dart';

class VerificationController {
  final ValueNotifier<VerificationStatus> status =
  ValueNotifier(VerificationStatus.idle);

  Future<void> submit() async {
    // Step 1: Start processing
    status.value = VerificationStatus.processing;

    // Temporary delay for testing.
    // Later this will be replaced with real validation and API logic.
    await Future.delayed(
      const Duration(seconds: 2),
    );

    // Step 2: Temporary success
    status.value = VerificationStatus.success;
  }

  void reset() {
    status.value = VerificationStatus.idle;
  }

  void dispose() {
    status.dispose();
  }
}