import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:test1/features/auftrag/data/services/auftrag_service.dart';
import 'package:test1/features/auftrag/domain/models/auftrag_model.dart';
import '../../../../core/routing/app_routes.dart';

class AuftragScreen extends StatefulWidget {
  final String token;

  const AuftragScreen({super.key, required this.token});

  @override
  State<AuftragScreen> createState() => _AuftragScreenState();
}

class _AuftragScreenState extends State<AuftragScreen> {
  final AuftragService _auftragService = AuftragService();
  List<AuftragModel> _originalAuftraege = [];
  List<PlutoRow> _rows = [];
  List<PlutoColumn> _columns = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
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
      _originalAuftraege = auftraege;
      _rows =
          auftraege.map((auftrag) {
            return PlutoRow(
              cells: {
                'id': PlutoCell(value: auftrag.id),
                'name': PlutoCell(value: auftrag.name),
                'auftragnr': PlutoCell(value: auftrag.auftragnr),
                'auftragtypname': PlutoCell(value: auftrag.auftragtypname),
                'auftragtyp': PlutoCell(value: auftrag.auftragtyp),
                'lastUpdated': PlutoCell(value: auftrag.lastUpdated),
                'infotext': PlutoCell(value: auftrag.infotext ?? ''),
                'auftragsstatusId': PlutoCell(value: auftrag.auftragsstatusId),
                'auftragsstatusName': PlutoCell(
                  value: auftrag.auftragsstatusName,
                ),
                'countchecklist': PlutoCell(value: auftrag.countchecklist),
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

  void _onRowDoubleTap(PlutoGridOnRowDoubleTapEvent event) {
    final tappedRow = event.row;
    final auftragId = tappedRow.cells['id']?.value;
    final auftrag = _originalAuftraege.firstWhere((a) => a.id == auftragId);

    Navigator.pushNamed(
      context,
      AppRoutes.auftragChecklists,
      arguments: auftrag.auftragchecklists,
    );
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
        mode: PlutoGridMode.selectWithOneTap,
        onRowDoubleTap: _onRowDoubleTap,
      ),
    );
  }
}
