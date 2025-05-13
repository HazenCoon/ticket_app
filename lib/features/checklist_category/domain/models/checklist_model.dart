/// Repräsentiert eine Checkliste
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

  /// Factory Methode zur Umwandlung von JSON in ChecklistModel
  ///
  /// Konvertiert ein JSON-Objekt in eine Instanz der [ChecklistModel] Klasse.
  /// Alle Felder des Models werden aus dem JSON extrahiert.
  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    return ChecklistModel(
      id: json['id']?.toString() ?? '',
      // Sicherstellen, dass die ID als String vorliegt
      name: json['name'] ?? '',
      // Fallback auf leeren String
      typeId: json['typeId'] is int ? json['typeId'] : 0,
      // Typ-Validierung für typeId
      typeName: json['typeName'] ?? '',
      owner: json['owner'] ?? '',
      appgroupId: json['appgroupId']?.toString() ?? '',
      // Sicherstellen, dass die AppgroupId als String vorliegt
      appgroupname: json['appgroupname'] ?? '',
      checklistcategoryId: json['checklistcategoryId']?.toString() ?? '',
      checklistcategoryName: json['checklistcategoryName'] ?? '',
      isfavorite:
          json['isfavorite'] ==
          true, // Sicherstellen, dass isfavorite als bool interpretiert wird
    );
  }
}
