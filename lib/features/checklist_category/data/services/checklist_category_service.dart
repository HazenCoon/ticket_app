import 'package:dio/dio.dart';
import 'package:test1/features/checklist_category/domain/models/checklist_category_model.dart';
import '../../../../core/network/api_config.dart' as api_config;

// Klasse ChecklistCategory
class ChecklistCategoryService {
  final Dio dio;

  // Konstruktor um Dio zu initialisieren
  ChecklistCategoryService(this.dio);

  // Methode zum Abrufen der Checklist-Kategorien und deren Checklisten
  Future<List<ChecklistCategoryModel>> fetchChecklistCategories({
    required String token,
  }) async {
    try {
      final response = await dio.get(
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
          throw Exception('Die Antwort ist nicht im erwarteten Listenformat');
        }
      }
      // Fehlerbehandlung
      else {
        throw Exception(
          'Fehler beim Abrufen der Kategorien: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Fehler beim Abrufen der Kategorien: ${e.message}');
    } catch (e) {
      throw Exception('Unbekannter Fehler: $e');
    }
  }
}
