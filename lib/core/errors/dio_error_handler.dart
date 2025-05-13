import 'package:dio/dio.dart';
import 'custom_exceptions.dart';

/// Fehlerbehandlung für Dio-Fehler (z.B. Netzwerkprobleme, API-Fehler).
///
/// Diese Methode übersetzt 'Dio-Exception' in die passenden benutzerdefinierten
/// Exceptions, um spezifische Fehler zu  behandeln.
Exception handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return handleGeneralError('Verbindung zum Server zeitüberschritten');
    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode ?? 0;
      if (statusCode == 401) {
        return handleGeneralError('Nicht autorisiert');
      } else if (statusCode == 404) {
        return handleGeneralError('Ressource nicht gefunden');
      } else if (statusCode == 500) {
        return handleGeneralError('Serverfehler');
      } else {
        return handleGeneralError('Unbekannter Fehler ($statusCode)');
      }
    case DioExceptionType.cancel:
      return handleGeneralError('Anfrage abgebrochen');
    case DioExceptionType.unknown:
    default:
      return handleGeneralError('Unbekannter Verbindungsfehler');
  }
}
/// Zentrale Methode zur Erstellung einer allgemeinen Fehler-Exception.
Exception handleGeneralError(String message) {
  return FetchDataException(message);
}
