import 'package:flutter/material.dart';

import 'features/verification/presentation/page/lsa_verification_screen.dart';

void main() {
  runApp(const LsaVerificationApp());
}

class LsaVerificationApp extends StatelessWidget {
  const LsaVerificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LSA Verification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LsaVerificationScreen(),
    );
  }
}
