import 'package:flutter/material.dart';
import 'package:test1/features/auftrag/domain/models/auftrag_checklist_model.dart';
import 'package:pluto_grid/pluto_grid.dart';

/// Zeigt die Checklisten eines Auftrags in einer PlutoGrid-Tabelle an
class AuftragChecklistScreen extends StatefulWidget {
  /// Liste der Checklisten, die zu einem Auftrag gehören
  final List<AuftragChecklistModel> checklists;

  const AuftragChecklistScreen({super.key, required this.checklists});

  @override
  State<AuftragChecklistScreen> createState() => _AuftragChecklistScreenState();
}

class _AuftragChecklistScreenState extends State<AuftragChecklistScreen> {
  late List<PlutoColumn> _columns;
  late List<PlutoRow> _rows;

  @override
  void initState() {
    super.initState();
    _setupColumns();
    _setupRows();
  }

  // Definiert die Spaltenstruktur für das Grid
  void _setupColumns() {
    _columns = [
      PlutoColumn(
        title: 'Auftrag',
        field: 'name',
        type: PlutoColumnTypeText(),
        enableSorting: true,
        enableEditingMode: false,
      ),
      PlutoColumn(
        title: 'Id',
        field: 'checklistId',
        type: PlutoColumnTypeText(),
        enableSorting: true,
        enableEditingMode: false,
      ),
      PlutoColumn(
        title: 'ChecklistName',
        field: 'checklistName',
        type: PlutoColumnTypeText(),
        enableSorting: true,
        enableEditingMode: false,
      ),
      PlutoColumn(
        title: 'CategoryId',
        field: 'checklistcategoryId',
        type: PlutoColumnTypeText(),
        enableSorting: true,
        enableEditingMode: false,
      ),
      PlutoColumn(
        title: 'CategoryName',
        field: 'checklistcategoryName',
        type: PlutoColumnTypeText(),
        enableSorting: true,
        enableEditingMode: false,
      ),
      PlutoColumn(
        title: 'AppgroupId',
        field: 'appgroupId',
        type: PlutoColumnTypeText(),
        enableSorting: true,
        enableEditingMode: false,
      ),
      PlutoColumn(
        title: 'AppgroupName',
        field: 'appgroupname',
        type: PlutoColumnTypeText(),
        enableSorting: true,
        enableEditingMode: false,
      ),
    ];
  }

  // Wandelt die Checklisten-Daten in Zeilen für das Grid um
  void _setupRows() {
    _rows =
        widget.checklists.map((checklist) {
          return PlutoRow(
            cells: {
              'name': PlutoCell(value: checklist.name),
              'checklistId': PlutoCell(value: checklist.checklistId),
              'checklistName': PlutoCell(value: checklist.checklistName),
              'checklistcategoryId': PlutoCell(
                value: checklist.checklistcategoryId,
              ),
              'checklistcategoryName': PlutoCell(
                value: checklist.checklistcategoryName,
              ),
              'appgroupId': PlutoCell(value: checklist.appgroupId),
              'appgroupname': PlutoCell(value: checklist.appgroupname),
            },
          );
        }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auftrag - Checklisten')),
      body: PlutoGrid(
        columns: _columns,
        rows: _rows,
        mode: PlutoGridMode.readOnly,
      ),
    );
  }
}
