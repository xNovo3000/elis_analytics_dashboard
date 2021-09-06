class InvalidTokenException implements Exception {

  InvalidTokenException(this.message);

  final message;

  @override String toString() => 'Invalid Thingsboard handshake. Error: $message';

}