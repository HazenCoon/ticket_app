import 'app_exception.dart';

/// Exception für Fehler beim Aufrufen von Daten (z.B. API-Fehler).
class FetchDataException extends AppException {
  FetchDataException(String message) : super(message, 'Fetch Data Error: ');
}
/// Exception für ungültige Anfragen (z. B. 400 Bad Request).
class BadRequestException extends AppException {
  BadRequestException(String message) : super(message, 'Bad Request: ');
}
/// Exception für nicht autorisierte Zugriffe (z.B. 401 Unauthorized).
class UnauthorizedException extends AppException {
  UnauthorizedException(String message) : super(message, 'Unauthorized: ');
}
/// Exception für nicht gefundene Ressourcen (z.B. 404 Not Found).
class NotFoundException extends AppException {
  NotFoundException(String message) : super(message, 'Not Found: ');
}
/// Exception für Serverprobleme (z.B. 500 Internal Server Error).
class ServerException extends AppException {
  ServerException(String message) : super(message, 'Server issue: ');
}
