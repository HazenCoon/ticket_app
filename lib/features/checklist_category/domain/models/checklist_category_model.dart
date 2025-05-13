import 'package:test1/features/checklist_category/domain/models/checklist_model.dart';

/// Datenmodell für eine Kategorie, die eine Gruppe von Checklisten enthält
class ChecklistCategoryModel {
  /// Eindeutige ID der Kategorie
  final String id;

  /// Anzeigename der Kategorie
  final String name;

  /// ID der zugehörigen Appgruppe
  final String appgroupId;

  /// Name der Appgruppe
  final String appgroupName;

  /// Liste der enthaltenen Checklisten
  final List<ChecklistModel> checklists; // Liste von Checklisten

  ChecklistCategoryModel({
    required this.id,
    required this.name,
    required this.appgroupId,
    required this.appgroupName,
    required this.checklists,
  });

  /// Factory-Methode zur Erstellung eines Objekts aus einem JSON-Map
  factory ChecklistCategoryModel.fromJson(Map<String, dynamic> json) {
    return ChecklistCategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      appgroupId: json['appgroupId']?.toString() ?? '',
      appgroupName: json['appgroupName'] ?? '',

      // Sicherstellen, dass checklists eine Liste ist
      checklists:
          (json['checklists'] as List?)
              ?.where((e) => e != null)
              .map((e) => ChecklistModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
