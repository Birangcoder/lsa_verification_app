import 'package:flutter/material.dart';

class PredecessorIdField extends StatelessWidget {
  final String predecessorId;
  final bool visible;

  const PredecessorIdField({
    super.key,
    required this.predecessorId,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    final field = TextField(
      controller: TextEditingController(text: predecessorId),
      readOnly: true,
      enabled: false,
      decoration: const InputDecoration(
        labelText: 'Predecessor ID (system, read-only)',
        border: OutlineInputBorder(),
      ),
    );

    return Offstage(offstage: !visible, child: field);
  }
}
