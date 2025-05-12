import 'package:dio/dio.dart';
import 'package:test1/core/errors/dio_error_handler.dart';
import 'package:test1/core/network/api_client.dart';
import 'package:test1/features/auftrag/domain/models/auftrag_model.dart';
import 'package:test1/core/network/api_config.dart' as api_config;

class AuftragService {
  Future<List<AuftragModel>> fetchAuftraege(String token) async {
    try {
      final dio = await ApiClient.getClient(token: token);
      final response = await dio.get(api_config.auftragEndpoint);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data['data'];
        return jsonList.map((json) => AuftragModel.fromJson(json)).toList();
      } else {
        throw handleGeneralError(
          'Fehler beim Abrufen der Aufträge: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is DioException) throw handleDioError(e);
      rethrow;
    }
  }
}
