import 'package:flutter/material.dart';

import '../../../../core/enums/verification_status.dart';
import '../../../../core/services/friction_logger.dart';
import '../../controller/verification_controller.dart';
import '../widgets/consent_code_field.dart';
import '../widgets/lsa_id_field.dart';
import '../widgets/predecessor_id_field.dart';
import '../widgets/status_banner.dart';
import '../widgets/verification_header.dart';
import '../widgets/verify_button.dart';

class LsaVerificationScreen extends StatefulWidget {
  const LsaVerificationScreen({super.key});

  static const String lsaId = 'LSA-7049';
  static const String predecessorId = 'PRED-9982-XYZ';

  @override
  State<LsaVerificationScreen> createState() => _LsaVerificationScreenState();
}

class _LsaVerificationScreenState extends State<LsaVerificationScreen> {
  late final TextEditingController _consentController;
  late final FocusNode _consentFocusNode;
  late final VerificationController _controller;
  late final FrictionLogger _frictionLogger;

  @override
  void initState() {
    super.initState();
    _consentController = TextEditingController();
    _consentFocusNode = FocusNode();
    _controller = VerificationController();
    _frictionLogger = FrictionLogger();

    _controller.shouldClearConsentField.addListener(_handleMemoryPurge);
  }

  void _handleMemoryPurge() {
    if (_controller.shouldClearConsentField.value) {
      _consentController.clear();
      _controller.acknowledgeMemoryPurged();
    }
  }

  Future<void> _submit() async {
    _frictionLogger.submitted();
    await _controller.submit(
      lsaId: LsaVerificationScreen.lsaId,
      parentConsentCode: _consentController.text,
      predecessorId: LsaVerificationScreen.predecessorId,
    );
  }

  void _reset() {
    _consentController.clear();
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.shouldClearConsentField.removeListener(_handleMemoryPurge);
    _consentController.dispose();
    _consentFocusNode.dispose();
    _frictionLogger.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const VerificationHeader(),
                  const SizedBox(height: 32),
                  const LsaIdField(),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<bool>(
                    valueListenable: _controller.isSubmissionLocked,
                    builder: (context, locked, child) {
                      return ConsentCodeField(
                        controller: _consentController,
                        focusNode: _consentFocusNode,
                        enabled: !locked,
                        onFocus: () => _frictionLogger.startTracking(),
                        onChanged: () => _frictionLogger.userInteracted(),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const PredecessorIdField(
                    predecessorId: LsaVerificationScreen.predecessorId,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  ValueListenableBuilder<bool>(
                    valueListenable: _controller.isSubmissionLocked,
                    builder: (context, locked, child) {
                      return ValueListenableBuilder<VerificationStatus>(
                        valueListenable: _controller.status,
                        builder: (context, status, child) {
                          return VerifyButton(
                            enabled: !locked,
                            processing: status == VerificationStatus.processing,
                            onPressed: _submit,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: _reset, child: const Text('Reset')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
