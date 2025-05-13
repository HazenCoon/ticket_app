/// Modell zur Repräsentation einer Auftrags-Checkliste
class AuftragChecklistModel {
  /// Name des Auftrags
  final String name;

  /// ID der Checkliste
  final String checklistId;

  /// Name der Checkliste
  final String checklistName;

  /// ID der Checklisten-Kategorie
  final String checklistcategoryId;

  /// Name der Checklisten-Kategorie
  final String checklistcategoryName;

  /// ID der App-Gruppe
  final String appgroupId;

  /// Name der App-Gruppe
  final String appgroupname;

  /// Konstruktor für AuftragsChecklistModel
  AuftragChecklistModel({
    required this.name,
    required this.checklistId,
    required this.checklistName,
    required this.checklistcategoryId,
    required this.checklistcategoryName,
    required this.appgroupId,
    required this.appgroupname,
  });

  /// Erzeugt eine Instanz aus einem JSON-Objekt
  factory AuftragChecklistModel.fromJson(Map<String, dynamic> json) {
    return AuftragChecklistModel(
      name: json['name'] ?? '',
      checklistId: json['checklistId'] ?? '',
      checklistName: json['checklistName'] ?? '',
      checklistcategoryId: json['checklistcategoryId'] ?? '',
      checklistcategoryName: json['checklistcategoryName'] ?? '',
      appgroupId: json['appgroupId'] ?? '',
      appgroupname: json['appgroupname'] ?? '',
    );
  }

  /// Konvertiert das Objekt in ein JSON-Format
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
