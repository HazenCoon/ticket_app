import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:test1/features/auftrag/data/services/auftrag_service.dart';
import 'package:test1/features/auftrag/domain/models/auftrag_model.dart';
import '../../../../app/routing/app_routes.dart';

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
  String _searchQuery = '';
  String? _selectedTyp;
  PlutoGridStateManager? _stateManager;

  List<String> get _auftragtypen =>
      _originalAuftraege
          .map((e) => e.auftragtypname)
          .toSet()
          .whereType<String>()
          .toList();

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

  bool get _isGridReady => mounted && _columns.isNotEmpty;

  Future<void> _loadAuftraege() async {
    try {
      final auftraege = await _auftragService.fetchAuftraege(widget.token);
      _originalAuftraege = auftraege;
      setState(() {
        _isLoading = false;
      });
      if (_isGridReady) {
        _filterRows();
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterRows() {
    if(_stateManager == null) return;
    final filtered =
        _originalAuftraege.where((auftrag) {
          final matchesName = auftrag.name.toLowerCase().contains(_searchQuery);
          final matchesTyp =
              _selectedTyp == null || auftrag.auftragtypname == _selectedTyp;
          return matchesName && matchesTyp;
        }).toList();

    _rows =
        filtered.map((auftrag) {
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

    _stateManager!.removeAllRows();
    _stateManager!.appendRows(_rows);
  }

  void _onRowDoubleTap(PlutoGridOnRowDoubleTapEvent event) {
    final tappedRow = event.row;
    final auftragId = tappedRow.cells['id']?.value;
    final auftrag = _originalAuftraege.firstWhere((a) => a.id == auftragId);

    Navigator.pushNamed(
      context,
      AppRoutes.auftragchecklists,
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
      appBar: AppBar(centerTitle: true, title: const Text('Aufträge')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Suche nach Auftrag',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                  _filterRows();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Typ-Bezeichnung',
                border: OutlineInputBorder(),
              ),
              value: _selectedTyp,
              items: [
                const DropdownMenuItem(value: null, child: Text('Alle')),
                ..._auftragtypen.map(
                  (typ) => DropdownMenuItem(value: typ, child: Text(typ)),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedTyp = value;
                  _filterRows();
                });
              },
            ),
          ),

          const SizedBox(height: 8.0),

          Expanded(
            child: PlutoGrid(
              columns: _columns,
              rows: _rows,
              onLoaded: (PlutoGridOnLoadedEvent event) {
                _stateManager = event.stateManager;
                if (_originalAuftraege.isNotEmpty) {
                  _filterRows();
                }
              },
              mode: PlutoGridMode.selectWithOneTap,
              onRowDoubleTap: _onRowDoubleTap,
            ),
          ),
        ],
      ),
    );
  }
}
