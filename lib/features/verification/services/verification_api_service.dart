import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/verification_request.dart';

class ApiResponse {
  final int statusCode;
  final Map<String, dynamic>? data;

  const ApiResponse({
    required this.statusCode,
    required this.data,
  });
}

class VerificationApiService {
  static const String endpoint =
      'https://api.habotconnect.com/v1/compliance/verify';

  final http.Client _client;

  VerificationApiService({http.Client? client})
      : _client = client ?? http.Client();

  Future<ApiResponse> submit({
    required VerificationRequest request,
    required String traceId,
    required String logicHash,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'x-trace-id': traceId,
      'x-logic-hash': logicHash,
    };

    http.Response response;
    try {
      response = await _client
          .post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(request.toJson()),
      )
          .timeout(const Duration(seconds: 10));
    } catch (error) {
      throw StateError('Network request failed or timed out: $error');
    }

    Map<String, dynamic>? decoded;
    try {
      if (response.body.isNotEmpty) {
        decoded = jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {
      decoded = null;
    }

    return ApiResponse(statusCode: response.statusCode, data: decoded);
  }

  void dispose() => _client.close();
}
