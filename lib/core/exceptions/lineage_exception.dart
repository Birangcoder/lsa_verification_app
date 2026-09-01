class LineageException implements Exception {
  final String message;

  const LineageException(this.message);

  @override
  String toString() {
    return 'LineageException: $message';
  }
}