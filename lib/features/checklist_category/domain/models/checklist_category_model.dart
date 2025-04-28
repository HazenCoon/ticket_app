import 'package:test1/features/checklist_category/domain/models/checklist_model.dart';

class ChecklistCategoryModel {
  final String id;
  final String name;
  final String appgroupId;
  final String appgroupName;
  final List<ChecklistModel> checklists; // Liste von Checklisten

  ChecklistCategoryModel({
    required this.id,
    required this.name,
    required this.appgroupId,
    required this.appgroupName,
    required this.checklists,
  });

  // Facorty-Methode zur Umwandlung von JSON
  factory ChecklistCategoryModel.fromJson(Map<String, dynamic> json) {
    return ChecklistCategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      appgroupId: json['appgroupId']?.toString() ?? '',
      appgroupName: json['appgroupName'] ?? '',

      // Sicherstellen, dass checklists eine Liste ist
      checklists:
          (json['checklists'] as List?)
              ?.map((checklistJson) {
                return checklistJson != null
                    ? ChecklistModel.fromJson(checklistJson)
                    : null;
              })
              .where((checklist) => checklist != null)
              .cast<ChecklistModel>()
              .toList() ??
          [],
    );
  }
}
