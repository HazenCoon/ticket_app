import 'package:dio/dio.dart';
import 'package:test1/features/checklist_category/data/models/checklist_category_model.dart';
import '../../../../core/network/api_config.dart' as api_config;

// Klasse ChecklistCategory
class ChecklistCategoryService {
  final Dio dio;

  ChecklistCategoryService(this.dio);

  // Methode fetchCategories
  Future<List<ChecklistCategoryModel>> fetchChecklistCategories(
    String token,
  ) async {
    final response = await dio.get(
      '${api_config.baseUrl}${api_config.checklistCategoryEndpoint}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    // Mapping der Response
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data.map((json) => ChecklistCategoryModel.fromJson(json)).toList();
    }
    // Fehlerbehandlung
    else {
      throw Exception(
        'Fehler beim Abrufen: ${response.statusCode} - ${response.statusMessage}',
      );
    }
  }
}
