import 'package:flutter/material.dart';
import 'package:test1/core/errors/app_exception.dart';
import 'package:test1/core/errors/custom_exceptions.dart';
import 'package:test1/core/network/api_client.dart';
import 'package:test1/features/checklist_category/data/services/checklist_category_service.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:test1/features/checklist_category/domain/models/checklist_category_model.dart';

// Klasse ChecklistCategoryScreen
class ChecklistCategoryScreen extends StatefulWidget {
  final String token; // Token wird über Konstruktor übergeben

  const ChecklistCategoryScreen({super.key, required this.token});

  @override
  State<ChecklistCategoryScreen> createState() =>
      _ChecklistCategoryScreenState();
}

// Klasse ChecklistCategoryScreenState
class _ChecklistCategoryScreenState extends State<ChecklistCategoryScreen> {
  List<ChecklistCategoryModel> categoryList = [];
  String? expandedCategoryId;
  late ChecklistCategoryService _service;
  List<PlutoColumn> _columns = [];
  final List<PlutoRow> _rows = [];
  bool _isLoading = true; // Ladezustand

  @override
  void initState() {
    super.initState();
    _setupColumns();
    _initializeData();
  }

  void _setupColumns() {
    _columns = [
      PlutoColumn(
        title: 'Id',
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
        title: 'AppgroupId',
        field: 'appgroupId',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'AppgroupName',
        field: 'appgroupName',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Typ-Id',
        field: 'typeId',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Typename',
        field: 'typeName',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Owner',
        field: 'owner',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Kategorie-Id',
        field: 'checklistcategoryId',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Kategorie-Name',
        field: 'checklistcategoryName',
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

  // Methode zum Laden der Daten
  Future<void> _initializeData() async {
    try {
      if (widget.token.isEmpty) {
        throw BadRequestException('Token ist leer');
      }

      final dio = await ApiClient.getClient(token: widget.token);
      _service = ChecklistCategoryService(dio);
      final categories = await _service.fetchChecklistCategories(
        token: widget.token,
      );

      // Konvertierung der Kategorien in PlutoRows
      for (var category in categories) {
        // Kategorie Zeile
        _rows.add(
          PlutoRow(
            cells: {
              'id': PlutoCell(value: category.id),
              'name': PlutoCell(value: category.name),
              'appgroupId': PlutoCell(value: category.appgroupId),
              'appgroupName': PlutoCell(value: category.appgroupName),
              'typeId': PlutoCell(value: ''),
              'typeName': PlutoCell(value: ''),
              'owner': PlutoCell(value: ''),
              'checklistcategoryId': PlutoCell(value: ''),
              'checklistcategoryName': PlutoCell(value: ''),
              'isfavorite': PlutoCell(value: ''),
            },
          ),
        );

        // Checklisten Zeilen unter der Kategorie
        _rows.addAll(
          (category.checklists.map((checklist) {
            return PlutoRow(
              cells: {
                'id': PlutoCell(value: checklist.id),
                'name': PlutoCell(value: checklist.name),
                'appgroupId': PlutoCell(value: checklist.appgroupId),
                'appgroupName': PlutoCell(value: checklist.appgroupname),
                'typeId': PlutoCell(value: checklist.typeId.toString()),
                'typeName': PlutoCell(value: checklist.typeName),
                'owner': PlutoCell(value: checklist.owner),
                'checklistcategoryId': PlutoCell(
                  value: checklist.checklistcategoryId,
                ),
                'checklistcategoryName': PlutoCell(
                  value: checklist.checklistcategoryName,
                ),
                'isfavorite': PlutoCell(
                  value: checklist.isfavorite ? 'Ja' : 'Nein',
                ),
              },
            );
          })),
        );
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      String errorMessage =
          e is AppException ? e.message : 'Unbekannter Fehler';
      debugPrint('Fehler beim Laden der Kategorien: $errorMessage');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Checklist Kategorien'))),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PlutoGrid(
                columns: _columns,
                rows: _rows,
                mode: PlutoGridMode.normal,
                configuration: const PlutoGridConfiguration(),
                // Wenn Zeile ausgewählt wird, öffnen/schließen
                onSelected: (PlutoGridOnSelectedEvent event) {
                  // Erweitert die Checkliste, wenn Zeile der Kategorie ausgewählt wird
                  setState(() {
                    final row = event.row;
                    if (row != null) {
                      final categoryId = row.cells['id']?.value;
                      setState(() {
                        expandedCategoryId =
                            (expandedCategoryId == categoryId)
                                ? null
                                : categoryId;
                      });
                    }
                  });
                },
              ),
    );
  }
}
