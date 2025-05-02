import 'package:dio/dio.dart';
import 'package:test1/core/errors/dio_error_handler.dart';
import 'api_config.dart' as api_config;

// Klasse ApiClient: Singleton Pattern
class ApiClient {
  //ApiClient: Erstellt Dio-Instanz mit Token im Header
  static Future<Dio> getClient({required String? token}) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: api_config.baseUrl,
          headers: {
            'Content-Type': 'application/json', // Es wird ein JSON gesendet
            'Accept': 'application/json', // Es wird ein JSON erwartet
            'x-api-token': token,
          },
        ),
      );
      return dio; // Rückgabe des DIO-Clients
    } catch (e) {
      throw handleGeneralError('Fehler beim Erstellen des API-Clients: $e');
    }
  }

  // Methode Authentifizierung
  static Future<String> authenticate(String email, String password) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: api_config.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      // Login-Request
      final response = await dio.post(
        api_config.loginEndpoint,
        data: {'email': email, 'password': password},
      );
      // Prüfung des Tokens
      if (response.statusCode == 200 && response.data['access_token'] != null) {
        return response.data['access_token'];
      } else {
        throw handleGeneralError(
          'Login fehlgeschlagen: Keine gültige Antwort erhalten.',
        );
      }
      // Fehlerbehandlung
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw handleGeneralError('Unbekannter Fehler beim Login: $e');
    }
  }
}
