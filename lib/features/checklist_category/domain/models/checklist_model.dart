class ChecklistModel {
  final String id;
  final String name;
  final int typeId;
  final String typeName;
  final String owner;
  final String appgroupId;
  final String appgroupname;
  final String checklistcategoryId;
  final String checklistcategoryName;
  final bool isfavorite;

  ChecklistModel({
    required this.id,
    required this.name,
    required this.typeId,
    required this.typeName,
    required this.owner,
    required this.appgroupId,
    required this.appgroupname,
    required this.checklistcategoryId,
    required this.checklistcategoryName,
    required this.isfavorite,
  });

  // Factory Methode zur Umwandlung von JSON in ChecklistModel
  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    return ChecklistModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      typeId: json['typeId'] is int ? json['typeId'] : 0,
      typeName: json['typeName'] ?? '',
      owner: json['owner'] ?? '',
      appgroupId: json['appgroupId']?.toString() ?? '',
      appgroupname: json['appgroupname'] ?? '',
      checklistcategoryId: json['checklistcategoryId']?.toString() ?? '',
      checklistcategoryName: json['checklistcategoryName'] ?? '',
      isfavorite: json['isfavorite'] == true,
    );
  }
}
