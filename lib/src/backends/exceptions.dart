class BackendException implements Exception {
  final int code;
  final String? message;

  const BackendException(this.code, this.message);

  @override
  String toString() => 'BackendException($code, "$message")';
}

class BackendParseException implements Exception {
  final Exception cause;
  final String url;

  const BackendParseException(this.cause, this.url);

  @override
  String toString() => 'BackendParseException($cause)';
}