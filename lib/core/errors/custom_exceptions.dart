import 'app_exception.dart';

class FetchDataException extends AppException {
  FetchDataException(String message) : super(message, 'Fetch Data Error: ');
}

class BadRequestException extends AppException {
  BadRequestException(String message) : super(message, 'Bad Request: ');
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message) : super(message, 'Unauthorized: ');
}

class NotFoundException extends AppException {
  NotFoundException(String message) : super(message, 'Not Found: ');
}

class ServerException extends AppException {
  ServerException(String message) : super(message, 'Server issue: ');
}
