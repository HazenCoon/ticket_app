class AuftragChecklistModel {
  final String name;
  final String checklistId;
  final String checklistName;
  final String checklistcategoryId;
  final String checklistcategoryName;
  final String appgroupId;
  final String appgroupname;

  AuftragChecklistModel({
    required this.name,
    required this.checklistId,
    required this.checklistName,
    required this.checklistcategoryId,
    required this.checklistcategoryName,
    required this.appgroupId,
    required this.appgroupname,
  });

  factory AuftragChecklistModel.fromJson(Map<String, dynamic> json) {
    return AuftragChecklistModel(
      name: json['name'],
      checklistId: json['checklistId'],
      checklistName: json['checklistName'],
      checklistcategoryId: json['checklistcategoryId'],
      checklistcategoryName: json['checklistcategoryName'],
      appgroupId: json['appgroupId'],
      appgroupname: json['appgroupname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'checklistId': checklistId,
      'checklistName': checklistName,
      'checklistcategoryId': checklistcategoryId,
      'checklistcategoryName': checklistcategoryName,
      'appgroupId': appgroupId,
      'appgroupname': appgroupname,
    };
  }
}
