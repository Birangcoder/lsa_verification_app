import 'package:flutter/material.dart';

import '../../../../core/enums/verification_status.dart';
import '../../controller/verification_controller.dart';
import '../widgets/consent_code_field.dart';
import '../widgets/lsa_id_field.dart';
import '../widgets/status_banner.dart';
import '../widgets/verification_header.dart';
import '../widgets/verify_button.dart';

class LsaVerificationScreen extends StatelessWidget {
  const LsaVerificationScreen({super.key});

  static final VerificationController _controller = VerificationController();

  static final TextEditingController _consentController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LSA Verification')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const VerificationHeader(),

              const SizedBox(height: 32),

              const LsaIdField(),

              const SizedBox(height: 20),

              // User input controller is now connected.
              ConsentCodeField(controller: _consentController),

              const SizedBox(height: 24),

              // Status + message.
              ValueListenableBuilder<VerificationStatus>(
                valueListenable: _controller.status,
                builder: (context, status, child) {
                  return ValueListenableBuilder<String>(
                    valueListenable: _controller.message,
                    builder: (context, message, child) {
                      return StatusBanner(status: status, message: message);
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              // Submit button.
              ValueListenableBuilder<VerificationStatus>(
                valueListenable: _controller.status,
                builder: (context, status, child) {
                  return VerifyButton(
                    isProcessing: status == VerificationStatus.processing,
                    onPressed: () async {
                      await _controller.submit(
                        parentConsentCode: _consentController.text,
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              // Reset.
              OutlinedButton(
                onPressed: () {
                  _consentController.clear();
                  _controller.reset();
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
