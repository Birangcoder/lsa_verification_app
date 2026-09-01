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

              const ConsentCodeField(),

              const SizedBox(height: 24),

              ValueListenableBuilder<VerificationStatus>(
                valueListenable: _controller.status,
                builder: (context, status, child) {
                  return StatusBanner(status: status);
                },
              ),

              const SizedBox(height: 24),

              ValueListenableBuilder<VerificationStatus>(
                valueListenable: _controller.status,
                builder: (context, status, child) {
                  return VerifyButton(
                    isProcessing: status == VerificationStatus.processing,
                    onPressed: () async {
                      await _controller.submit();
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              OutlinedButton(
                onPressed: () {
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
