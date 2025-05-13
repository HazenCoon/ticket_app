/// Abstrakte Basisklasse für alle App-spezifischen Exceptions.
abstract class AppException implements Exception {
  /// Fehlernachricht zur Anzeige oder Protokollierung.
  final String message;
  /// Optionales Präfix zur besseren Einordnung des Fehlertyps.
  final String? prefix;

  const AppException(this.message, [this.prefix]);

  @override
  String toString() => '$prefix$message';
}
