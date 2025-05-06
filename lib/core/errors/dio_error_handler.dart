import 'package:dio/dio.dart';
import 'custom_exceptions.dart';

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

// Zentrale Fehlerbehandlungsmethode
Exception handleGeneralError(String message) {
  return FetchDataException(message);
}
