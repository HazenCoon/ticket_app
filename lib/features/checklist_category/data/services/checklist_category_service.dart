import 'package:dio/dio.dart';
import 'package:test1/core/errors/custom_exceptions.dart';
import 'package:test1/core/errors/dio_error_handler.dart';
import 'package:test1/features/checklist_category/domain/models/checklist_category_model.dart';
import '../../../../core/network/api_config.dart' as api_config;

// Klasse ChecklistCategory
class ChecklistCategoryService {
  final Dio _dio;

  // Konstruktor um Dio zu initialisieren
  ChecklistCategoryService(this._dio);

  // Methode zum Abrufen der Checklist-Kategorien und deren Checklisten
  Future<List<ChecklistCategoryModel>> fetchChecklistCategories({
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        '${api_config.baseUrl}${api_config.checklistCategoryEndpoint}',
        options: Options(
          headers: {
            'x-api-token': token,
            'Content-Type': 'application/json',
            'Accept': 'application/json', // Erwartet JSON-Antwort
          },
        ),
      );

      // Überprüfen der Antwort und Mapping auf das Modell
      if (response.statusCode == 200 && response.data != null) {
        if (response.data is List) {
          // Umwandlung der Antwort in eine Liste von ChecklistCategoryModel
          return (response.data as List)
              .map((json) => ChecklistCategoryModel.fromJson(json))
              .toList();
        } else {
          throw FetchDataException(
            'Die Antwort ist nicht im erwarteten Listenformat',
          );
        }
      }
      // Fehlerbehandlung
      else {
        throw FetchDataException(
          'Fehler beim Abrufen der Kategorien: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      throw FetchDataException('Unbekannter Fehler: $e');
    }
  }
}
