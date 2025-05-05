import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class ChecklistScreen extends StatefulWidget {
  final String categoryId;
  final List<dynamic> checklists;

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
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Typ',
        field: 'typename',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Favorit',
        field: 'isfavorite',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
    ];
  }

  // API-Call für die Checklisten
  Future<void> _loadChecklists() async {
    final rows =
        widget.checklists.map((checklist) {
          return PlutoRow(
            cells: {
              'id': PlutoCell(value: checklist['id']),
              'name': PlutoCell(value: checklist['name']),
              'typename': PlutoCell(value: checklist['typename']),
              'isfavorite': PlutoCell(
                value: checklist['isfavorite'] ? 'Ja' : 'Nein',
              ),
            },
          );
        }).toList();
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
