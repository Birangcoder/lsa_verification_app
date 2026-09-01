import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../core/enums/verification_status.dart';
import '../../../core/exceptions/lineage_exception.dart';
import '../../../core/services/hash_service.dart';
import '../../../core/services/trace_service.dart';
import '../models/verification_request.dart';
import '../services/verification_api_service.dart';

class VerificationController {
  final VerificationApiService _apiService;

  final ValueNotifier<VerificationStatus> status = ValueNotifier(
    VerificationStatus.idle,
  );

  final ValueNotifier<String> message = ValueNotifier(
    'System is idle and ready for verification.',
  );

  final ValueNotifier<bool> isSubmissionLocked = ValueNotifier(false);

  final ValueNotifier<bool> shouldClearConsentField = ValueNotifier(false);

  VerificationController({VerificationApiService? apiService})
    : _apiService = apiService ?? VerificationApiService();

  Future<void> submit({
    required String lsaId,
    required String parentConsentCode,
    String? predecessorId = 'PRED-9982-XYZ',
  }) async {
    if (isSubmissionLocked.value) {
      message.value = 'Submission is locked due to a compliance failure.';
      return;
    }

    status.value = VerificationStatus.processing;
    message.value = 'Validating submission...';

    try {
      if (parentConsentCode.trim().isEmpty) {
        throw const FormatException('parent_consent_code cannot be empty.');
      }

      if (predecessorId == null || predecessorId.trim().isEmpty) {
        throw const LineageException(
          'Missing predecessor_id. Network request blocked immediately.',
        );
      }

      final traceId = TraceService.generateTraceId();

      final request = VerificationRequest(
        predecessorId: predecessorId.trim(),
        lsaId: lsaId.trim(),
        parentConsentCode: parentConsentCode.trim(),
        timestampUtc: DateTime.now().toUtc().toIso8601String(),
      );

      final logicHash = HashService.generateLogicHash(
        jsonEncode(request.toJson()),
      );

      final response = await _apiService.submit(
        request: request,
        traceId: traceId,
        logicHash: logicHash,
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError('Server returned HTTP ${response.statusCode}.');
      }

      if (response.data == null) {
        throw StateError('API response is null or unparseable.');
      }

      final responseStatus = response.data!['status'];

      if (responseStatus == null) {
        throw StateError('API response contains null status.');
      }

      status.value = VerificationStatus.success;
      message.value = 'Verification successful. Trace ID: $traceId';
    } on LineageException catch (error) {
      _failClosed(reason: error.message);
    } on FormatException catch (error) {
      _failClosed(reason: error.message, lockButton: false, purge: false);
    } catch (error) {
      _failClosed(reason: error.toString());
    }
  }

  void _failClosed({
    required String reason,
    bool lockButton = true,
    bool purge = true,
  }) {
    status.value = VerificationStatus.quarantined;
    message.value = 'Data Quarantined – Compliance Failure\n$reason';

    if (lockButton) {
      isSubmissionLocked.value = true;
    }

    if (purge) {
      shouldClearConsentField.value = true;
    }

    debugPrint('==============================');
    debugPrint('FAIL-CLOSED SECURITY TRIGGERED');
    debugPrint('Reason: $reason');
    debugPrint('Volatile request data purged: $purge');
    debugPrint('Submission locked: ${isSubmissionLocked.value}');
    debugPrint('==============================');
  }

  void acknowledgeMemoryPurged() {
    shouldClearConsentField.value = false;
  }

  void reset() {
    status.value = VerificationStatus.idle;
    message.value = 'System reset. Ready for a new verification.';
    isSubmissionLocked.value = false;
  }

  void dispose() {
    status.dispose();
    message.dispose();
    isSubmissionLocked.dispose();
    shouldClearConsentField.dispose();
    _apiService.dispose();
  }
}
