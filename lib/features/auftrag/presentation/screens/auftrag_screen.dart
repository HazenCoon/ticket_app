import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:test1/features/auftrag/data/services/auftrag_service.dart';
import 'package:test1/features/auftrag/domain/models/auftrag_model.dart';
import '../../../../app/routing/app_routes.dart';

/// Zeigt eine Liste aller Aufträge in einer PlutoGrid-Tabelle.
/// Bietet Suche nach Auftragsname sowie Filterung nach Auftragstyp.
class AuftragScreen extends StatefulWidget {
  final String token;

  const AuftragScreen({super.key, required this.token});

  @override
  State<AuftragScreen> createState() => _AuftragScreenState();
}

class _AuftragScreenState extends State<AuftragScreen> {
  final AuftragService _auftragService = AuftragService();

  List<AuftragModel> _originalAuftraege =
      []; // Ursprüngliche Liste aller Aufträge
  List<PlutoRow> _rows = []; // Gefilterte Rows für die Tabelle
  List<PlutoColumn> _columns = []; // Spaltendefinition für PlutoGrid

  bool _isLoading = true; // Zeigt Ladezustand an
  String? _errorMessage; // Fehlermeldung, falls vorhanden

  String _searchQuery = ''; // Suchbegriff für Namessuche
  String? _selectedTyp; // Filterwert für Auftragstyp
  PlutoGridStateManager? _stateManager; // Referenz auf PlutoGrid-Manager

  /// Alle verfügbaren Auftragtypen für das Dropdown
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

  /// Definiert die Spaltenstruktur des PlutoGrids
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

  /// Lädt die Aufträge vom Backend und zeigt sie an
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

  /// Filtert die Aufträge basierend auf Name und Typ-Auswahl
  void _filterRows() {
    if (_stateManager == null) return;
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

  /// Bei Doppelklick: Navigation zu den Checklisten des Auftrags
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
          // Suchfeld
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
          // Dropdown für Auftragstyp
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

          // Tabelle
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
