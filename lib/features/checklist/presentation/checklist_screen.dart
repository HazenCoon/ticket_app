import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:test1/features/checklist_category/domain/models/checklist_model.dart';

class ChecklistScreen extends StatefulWidget {
  final String categoryId;
  final List<ChecklistModel> checklists;

  const ChecklistScreen({
    super.key,
    required this.categoryId,
    required this.checklists,
  });

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  List<PlutoColumn> _columns = [];
  final List<PlutoRow> _rows = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _setupColumns();
    _loadChecklists();
  }

  // Definition der Spalten für das Grid
  void _setupColumns() {
    _columns = [
      PlutoColumn(
        title: 'ID',
        field: 'id',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'typeId',
        field: 'typeId',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Typ',
        field: 'typename',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'owner',
        field: 'owner',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'appgroupId',
        field: 'appgroupId',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'appgroupname',
        field: 'appgroupname',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'checklistcategoryId',
        field: 'checklistcategoryId',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'checklistcategoryName',
        field: 'checklistcategoryName',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Favorit',
        field: 'isfavorite',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
    ];
  }

  // API-Call für die Checklisten
  Future<void> _loadChecklists() async {
    final List<PlutoRow> rows =
        widget.checklists.isNotEmpty
            ? widget.checklists.map((ChecklistModel checklist) {
              return PlutoRow(
                cells: {
                  'id': PlutoCell(value: checklist.id),
                  'name': PlutoCell(value: checklist.name),
                  'typeId': PlutoCell(value: checklist.typeId),
                  'typename': PlutoCell(value: checklist.typeName),
                  'owner': PlutoCell(value: checklist.owner),
                  'appgroupId': PlutoCell(value: checklist.appgroupId),
                  'appgroupname': PlutoCell(value: checklist.appgroupname),
                  'checklistcategoryId': PlutoCell(
                    value: checklist.checklistcategoryId,
                  ),
                  'checklistcategoryName': PlutoCell(
                    value: checklist.checklistcategoryName,
                  ),
                  'isfavorite': PlutoCell(
                    value: checklist.isfavorite ? 'Nein' : 'Ja',
                  ),
                },
              );
            }).toList()
            : [];

    setState(() {
      _rows.clear();
      _rows.addAll(rows);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checklisten für Kategorie')),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PlutoGrid(
                columns: _columns,
                rows: _rows,
                mode: PlutoGridMode.normal,
              ),
    );
  }
}
