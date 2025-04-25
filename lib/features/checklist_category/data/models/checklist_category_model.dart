import 'package:test1/features/checklist_category/data/models/checklist_model.dart';

class ChecklistCategoryModel {
  final String id;
  final String name;
  final String appgroupId;
  final String appgroupName;
  final List<ChecklistModel> checklists;

  ChecklistCategoryModel({
    required this.id,
    required this.name,
    required this.appgroupId,
    required this.appgroupName,
    required this.checklists,
  });

  factory ChecklistCategoryModel.fromJson(Map<String, dynamic> json) {
    final checklistList =
        (json['checklists'] as List<dynamic>? ?? [])
            .map((e) => ChecklistModel.fromJson(e))
            .toList();

    return ChecklistCategoryModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      appgroupId: json['appgroupId'].toString(),
      appgroupName: json['appgroupName'] ?? '',
      checklists: checklistList,
    );
  }
}
