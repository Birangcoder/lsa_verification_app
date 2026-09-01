import 'dart:async';

class FrictionLogger {
  Timer? _timer;
  DateTime? _focusStartTime;

  bool _alreadyLogged = false;

  void startTracking() {
    cancel();

    _alreadyLogged = false;
    _focusStartTime = DateTime.now();

    _timer = Timer(const Duration(seconds: 5), () {
      if (_alreadyLogged || _focusStartTime == null) {
        return;
      }

      _alreadyLogged = true;

      final duration = DateTime.now().difference(_focusStartTime!);

      print(
        '[UI_FRICTION_LOG] '
            'Timestamp: ${DateTime.now().toUtc().toIso8601String()} '
            '| Field: parent_consent_code '
            '| Hesitation Duration: '
            '${duration.inMilliseconds / 1000}s',
      );
    });
  }

  void userInteracted() {
    cancel();
  }

  void submitted() {
    cancel();
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    cancel();
  }
}
