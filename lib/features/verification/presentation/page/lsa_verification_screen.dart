import 'package:flutter/material.dart';

import '../../../../core/enums/test_scenario.dart';
import '../../../../core/enums/verification_status.dart';
import '../../../../core/services/friction_logger.dart';
import '../../controller/verification_controller.dart';
import '../widgets/consent_code_field.dart';
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
            children: [
              const Text(
                'LSA Onboarding Gate',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'HabotConnect Data Compliance',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 32),

              // LSA ID
              const Text(
                'LSA ID',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: TextEditingController(text: 'LSA-7049'),
                readOnly: true,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),

              const SizedBox(height: 20),

              // Parent Consent Code
              const Text(
                'Parent Consent Code',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter parent consent code',
                ),
              ),

              const SizedBox(height: 24),

              // Status
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Status: Idle',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic will be added later.
                  },
                  child: const Text('Verify & Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
