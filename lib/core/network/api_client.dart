import 'package:dio/dio.dart';
import 'api_config.dart';

// Klasse ApiClient: Singleton Pattern
class ApiClient {
  static Dio? _dio;

  //ApiClient: Erstellt Dio-Instanz mit Token im Header
  static Future<Dio> getClient({String? token}) async {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json', // Es wird ein JSON gesendet
          'Accept': 'application/json', // Es wird ein JSON erwartet
          'x-api-token': token,
        },
      ),
    );

    return _dio!; // Rückgabe des DIO-Clients
  }

  // Methode authentifizierung
  static Future<String> authenticate(String email, String password) async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      // Login-Request
      final response = await dio.post(
        baseUrl + loginEndpoint,
        data: {'email': email, 'password': password},
      );

      // Prüfung des Tokens
      if (response.statusCode == 200 && response.data['access_token'] != null) {
        return response.data['access_token'];
      } else {
        throw Exception('Login fehlgeschlagen: Falsche Zugangsdaten');
      }

      // Fehlerbehandlung
    } on DioException catch (e) {
      throw Exception(
        'Login fehlgeschlagen: ${e.response?.statusCode} ${e.message}',
      );
    }
  }
}
