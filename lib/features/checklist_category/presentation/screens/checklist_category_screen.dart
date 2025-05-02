import 'package:flutter/material.dart';
import 'package:test1/core/network/api_client.dart';
import 'package:test1/core/routing/app_routes.dart';
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
  List<PlutoRow> _rows = [];
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
        title: 'Appgroup',
        field: 'appgroupName',
        type: PlutoColumnType.text(),
        enableSorting: true,
      ),
    ];
  }

  // Methode zum Laden der Daten
  Future<void> _initializeData() async {
    try {
      if (widget.token.isEmpty) {
        throw Exception('Token ist leer');
      }

      final dio = await ApiClient.getClient(token: widget.token);
      _service = ChecklistCategoryService(dio);
      final categories = await _service.fetchChecklistCategories(
        token: widget.token,
      );

      // Konvertierung der Kategorien in PlutoRows
      setState(() {
        _rows = [];
        for (var category in categories) {
          // Kategorie Zeile
          _rows.add(
            PlutoRow(
              cells: {
                'id': PlutoCell(value: category.id),
                'name': PlutoCell(value: category.name),
                'appgroupName': PlutoCell(value: category.appgroupName),
              },
            ),
          );

          // Checklisten Zeilen unter der Kategorie
          _rows.addAll(
            category.checklists.map((checklist) {
              return PlutoRow(
                cells: {
                  'id': PlutoCell(value: checklist.id),
                  'name': PlutoCell(value: checklist.name),
                  'typeId': PlutoCell(value: checklist.typeId.toString()),
                  'typename': PlutoCell(value: checklist.typename),
                  'owner': PlutoCell(value: checklist.owner),
                  'isfavorite': PlutoCell(
                    value: checklist.isfavorite.toString()),
                },
              );
            }).toList(),
          );
        }
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Fehler beim Laden der Kategorien: $e');
      setState(() {
        _isLoading = false;
      });
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
                // Wenn Zeile ausgewählt wird, öffnen/schließen
                onSelected: (PlutoGridOnSelectedEvent event) {
                    final row = event.row;
                    if (row != null) {
                      final typeId = row.cells['typeId']?.value;
                      final checklistcategoryId = row.cells['checklistcategoryId']?.value;

                      final isCategoryRow = (typeId == '' || typeId == null) && (checklistcategoryId == '' || checklistcategoryId == null);

                      if (isCategoryRow) {['id']?.value;
                        setState(() {
                          expandedCategoryId = (expandedCategoryId == checklistcategoryId) ? null : checklistcategoryId;
                        });
                        Navigator.pushNamed(
    context,
    AppRoutes.ChecklistScreen,
    arguments: checklistcategoryId,
    );
                      }
                    }
                  },))
    );
                    ),
    );
  }
}
