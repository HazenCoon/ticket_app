import 'auftrag_checklist_model.dart';

class AuftragModel {
  final String id;
  final String name;
  final String auftragnr;
  final String auftragtypname;
  final int auftragtyp;
  final String lastUpdated;
  final String? infotext;
  final String auftragsstatusId;
  final String auftragsstatusName;
  final List<AuftragChecklistModel> auftragchecklists;
  final int countauftragpos;
  final int countchecklistdata;
  final int countchecklist;

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

  factory AuftragModel.fromJson(Map<String, dynamic> json) {
    return AuftragModel(
      id: json['id'],
      name: json['name'],
      auftragnr: json['auftragnr'],
      auftragtypname: json['auftragtypname'],
      auftragtyp: json['auftragtyp'],
      lastUpdated: json['lastUpdated'],
      auftragsstatusId: json['auftragsstatusId'],
      auftragsstatusName: json['auftragsstatusName'],
      auftragchecklists:
          (json['checklists'] as List<dynamic>?)
              ?.map((e) => AuftragChecklistModel.fromJson(e))
              .toList() ??
          [],
      countauftragpos: json['countauftragpos'],
      countchecklistdata: json['countchecklistdata'],
      countchecklist: json['countchecklist'],
    );
  }

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
