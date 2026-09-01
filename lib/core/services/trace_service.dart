import 'package:uuid/uuid.dart';

class TraceService {
  TraceService._();

  static const Uuid _uuid = Uuid();

  static String generateTraceId() {
    return _uuid.v4();
  }
}