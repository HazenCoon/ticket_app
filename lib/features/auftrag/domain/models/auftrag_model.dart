import 'auftrag_checklist_model.dart';

/// Modell zur Darstellung eines Auftrags mit zugehörigen Checklisten
class AuftragModel {
  /// Eindeutige ID des Auftrags
  final String id;

  /// Anzeigename des Auftrags
  final String name;

  /// Auftragsnummer
  final String auftragnr;

  /// Name des Auftragstyps
  final String auftragtypname;

  /// Typ-ID des Auftrags
  final int auftragtyp;

  /// Letztes Änderungsdatum
  final String lastUpdated;

  /// Optionaler Infotext zum Auftrag
  final String? infotext;

  /// Status-ID des Auftrags
  final String auftragsstatusId;

  /// Klartext-Status des Auftrags
  final String auftragsstatusName;

  /// Liste der Checklisten, die diesem Auftrag zugeordnet sind
  final List<AuftragChecklistModel> auftragchecklists;

  /// Anzahl der Auftragspositionen
  final int countauftragpos;

  /// Anzahl ausgefüllter Checklisten-Daten
  final int countchecklistdata;

  /// Anzahl der zugeordneten Checklisten
  final int countchecklist;

  /// Konstruktor für AuftragModel
  AuftragModel({
    required this.id,
    required this.name,
    required this.auftragnr,
    required this.auftragtypname,
    required this.auftragtyp,
    required this.lastUpdated,
    this.infotext,
    required this.auftragsstatusId,
    required this.auftragsstatusName,
    required this.auftragchecklists,
    required this.countauftragpos,
    required this.countchecklistdata,
    required this.countchecklist,
  });

  /// Erstellt ein AuftragModel-Objekt aus einer JSON-Map
  factory AuftragModel.fromJson(Map<String, dynamic> json) {
    return AuftragModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      auftragnr: json['auftragnr'] ?? '',
      auftragtypname: json['auftragtypname'] ?? '',
      auftragtyp: json['auftragtyp'] ?? 0,
      lastUpdated: json['lastUpdated'] ?? '',
      auftragsstatusId: json['auftragsstatusId'] ?? '',
      auftragsstatusName: json['auftragsstatusName'] ?? '',
      auftragchecklists:
          (json['auftragchecklists'] as List<dynamic>?)
              ?.map((e) => AuftragChecklistModel.fromJson(e))
              .toList() ??
          [],
      countauftragpos: json['countauftragpos'] ?? 0,
      countchecklistdata: json['countchecklistdata'] ?? 0,
      countchecklist: json['countchecklist'] ?? 0,
    );
  }

  /// Konvertiert das AuftragModel in eine JSON-Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'auftragnr': auftragnr,
      'auftragtypname': auftragtypname,
      'auftragtyp': auftragtyp,
      'lastUpdated': lastUpdated,
      'infotext': infotext,
      'auftragsstatusId': auftragsstatusId,
      'auftragsstatusName': auftragsstatusName,
      'auftragchecklists': auftragchecklists.map((e) => e.toJson()).toList(),
      'countauftragpos': countauftragpos,
      'countchecklistdata': countchecklistdata,
      'countchecklist': countchecklist,
    };
  }
}
