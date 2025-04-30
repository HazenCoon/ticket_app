abstract class AppException implements Exception {
  final String message;
  final String? prefix;

  const AppException(this.message, [this.prefix]);

  @override
  String toString() => '$prefix$message';
}
