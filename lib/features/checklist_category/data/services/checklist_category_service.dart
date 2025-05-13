import 'package:dio/dio.dart';
import 'package:test1/core/errors/custom_exceptions.dart';
import 'package:test1/core/errors/dio_error_handler.dart';
import 'package:test1/features/checklist_category/domain/models/checklist_category_model.dart';
import '../../../../core/network/api_config.dart' as api_config;

/// Service zum Abrufen von Checklist-Kategorien und deren Checklisten
class ChecklistCategoryService {
  final Dio _dio;

  /// Erstellt den Service mit einer Dio-Instanz
  ChecklistCategoryService(this._dio);

  /// Ruft alle Checklist-Kategorien inklusive Checklisten vom Backend ab
  ///
  /// [token] - gültiger Benutzer-Token für Authentifizierung
  ///
  /// Gibt eine Liste von [ChecklistCategoryModel] zurück
  ///
  /// Wirft [FetchDataException] oder eine Dio-basierte Exception bei Fehlern
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
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is List) {
          return (response.data as List)
              .map((json) => ChecklistCategoryModel.fromJson(json))
              .toList();
        } else {
          throw FetchDataException(
            'Die Antwort ist nicht im erwarteten Listenformat',
          );
        }
      } else {
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
