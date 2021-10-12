class IncompatibleSeriesException implements Exception {

  IncompatibleSeriesException(this.message);

  final message;

  @override String toString() => 'Incompatible series. Error: $message';

}