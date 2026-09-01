import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashService {
  HashService._();

  static String generateLogicHash(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }
}