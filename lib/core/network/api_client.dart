import 'package:dio/dio.dart';
import 'package:test1/core/errors/dio_error_handler.dart';
import 'api_config.dart' as api_config;

class ApiClient {
  /// Erstellt und gibt eine Dio-Instanz mit dem Token im Header zurück.
  ///
  /// Diese Methode ist als Singleton implementiert und stellt sicher,
  /// dass ein globaler Dio-Client mit den notwendigen Headern
  /// (einschließlich des Authentifizierungs-Tokens) bereitgestellt wird.
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
      // Fehlerbehandlung für Dio-Client-Erstellung
      throw handleGeneralError('Fehler beim Erstellen des API-Clients: $e');
    }
  }

  /// Authentifiziert den Benutzer und gibt ein Authentifizierungstoken zurück.
  ///
  /// Diese Methode sendet die Anmeldedaten an den Server und prüft, ob die
  /// Rückmeldung des Servers ein gültiges Token enthält.
  static Future<String> authenticate(String email, String password) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: api_config.baseUrl,
          headers: {
            'Content-Type': 'application/json', // JSON wird gesendet
            'Accept': 'application/json', // JSON wird erwartet
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
        return response
            .data['access_token']; // Erfolgreiche Rückgabe des Tokens
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
