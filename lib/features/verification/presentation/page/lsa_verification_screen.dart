import 'package:flutter/material.dart';

import '../widgets/consent_code_field.dart';
import '../widgets/lsa_id_field.dart';
import '../widgets/status_banner.dart';
import '../widgets/verification_header.dart';
import '../widgets/verify_button.dart';

class LsaVerificationScreen extends StatelessWidget {
  const LsaVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LSA Verification')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              VerificationHeader(),

              SizedBox(height: 32),

              LsaIdField(),

              SizedBox(height: 20),

              ConsentCodeField(),

              SizedBox(height: 24),

              StatusBanner(),

              SizedBox(height: 24),

              VerifyButton(),
            ],
          ),
        ),
      ),
    );
  }
}
