import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:test1/features/auftrag/data/services/auftrag_service.dart';

class AuftragScreen extends StatefulWidget {
  final String token;

  const AuftragScreen({super.key, required this.token});

  @override
  State<AuftragScreen> createState() => _AuftragScreenState();
}

class _AuftragScreenState extends State<AuftragScreen> {
  late AuftragService _auftragService;

  List<PlutoRow> _rows = [];
  List<PlutoColumn> _columns = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _auftragService = AuftragService();
    _setupColumns();
    _loadAuftraege();
  }

  void _setupColumns() {
    _columns = [
      PlutoColumn(
        title: 'Id',
        field: 'id',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Auftrag',
        field: 'name',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Auftragnr.',
        field: 'auftragnr',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Typ-Bezeichnung',
        field: 'auftragtypname',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Typ',
        field: 'auftragtyp',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Letztes Update',
        field: 'lastUpdated',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Info',
        field: 'infotext',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Status-Id',
        field: 'auftragsstatusId',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Status',
        field: 'auftragsstatusName',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Anzahl Checklists',
        field: 'countchecklist',
        type: PlutoColumnTypeText(),
        enableEditingMode: false,
        enableSorting: true,
      ),
    ];
  }

  Future<void> _loadAuftraege() async {
    try {
      final auftraege = await _auftragService.fetchAuftraege(widget.token);
      _rows =
          auftraege.map((auftrag) {
            return PlutoRow(
              cells: {
                'id': PlutoCell(value: auftrag.id),
                'Auftrag': PlutoCell(value: auftrag.name),
                'Auftragnr': PlutoCell(value: auftrag.auftragnr),
                'Typ-Bezeichnung': PlutoCell(value: auftrag.auftragtypname),
                'Typ': PlutoCell(value: auftrag.auftragtyp),
                'Letztes Update': PlutoCell(value: auftrag.lastUpdated),
                'Info': PlutoCell(value: auftrag.infotext),
                'Status-Id': PlutoCell(value: auftrag.auftragsstatusId),
                'Status': PlutoCell(value: auftrag.auftragsstatusName),
                'Anzahl Checklists': PlutoCell(value: auftrag.countchecklist),
              },
            );
          }).toList();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Aufträge')),
      body: PlutoGrid(
        columns: _columns,
        rows: _rows,
        mode: PlutoGridMode.normal,
      ),
    );
  }
}
