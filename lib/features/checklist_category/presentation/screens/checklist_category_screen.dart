import 'package:flutter/material.dart';
import 'package:test1/core/errors/dio_error_handler.dart';
import 'package:test1/core/network/api_client.dart';
import 'package:test1/features/checklist_category/data/services/checklist_category_service.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:test1/features/checklist_category/domain/models/checklist_category_model.dart';
import '../../../../app/routing/app_routes.dart';

/// Bildschirm für die Anzeige der Checklist-Kategorien
class ChecklistCategoryScreen extends StatefulWidget {
  final String token; // Token wird über Konstruktor übergeben

  const ChecklistCategoryScreen({super.key, required this.token});

  @override
  State<ChecklistCategoryScreen> createState() =>
      _ChecklistCategoryScreenState();
}

/// Zustand und Logik für den ChecklistCategoryScreen
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

  /// Definiert die Spalten des PlutoGrids
  void _setupColumns() {
    _columns = [
      PlutoColumn(
        title: 'Id',
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
        title: 'AppgroupName',
        field: 'appgroupName',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
      PlutoColumn(
        title: 'Typ',
        field: 'typeName',
        type: PlutoColumnType.text(),
        enableEditingMode: false,
        enableSorting: true,
      ),
    ];
  }

  /// Lädt die Checklisten-Kategoriedaten vom API
  Future<void> _initializeData() async {
    try {
      if (widget.token.isEmpty) {
        throw handleGeneralError('Token ist leer oder null');
      }

      final dio = await ApiClient.getClient(token: widget.token);
      _service = ChecklistCategoryService(dio);
      categoryList = await _service.fetchChecklistCategories(
        token: widget.token,
      );
      setState(() {
        _rows.clear();
        for (var category in categoryList) {
          _rows.add(
            PlutoRow(
              cells: {
                'id': PlutoCell(value: category.id),
                'name': PlutoCell(value: category.name),
                'appgroupName': PlutoCell(value: category.appgroupName),
                'typeName': PlutoCell(value: 'Kategorie'),
              },
            ),
          );
          _rows.addAll(
            category.checklists.map((checklist) {
              return PlutoRow(
                cells: {
                  'id': PlutoCell(value: checklist.id),
                  'name': PlutoCell(value: checklist.name),
                  'appgroupName': PlutoCell(value: checklist.appgroupname),
                  'typeName': PlutoCell(value: 'Kategorie'),
                },
              );
            }),
          );
        }
        _isLoading = false;
      });
    } catch (e) {
      final message = handleGeneralError(e.toString());
      debugPrint('Dio-Fehler: $message');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Checklist Kategorien'))),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PlutoGrid(
                columns: _columns,
                rows: _rows,
                mode: PlutoGridMode.normal,
                onRowDoubleTap: (PlutoGridOnRowDoubleTapEvent event) {
                  final row = event.row;
                  final rowType = row.cells['typeName']?.value;
                  if (rowType == 'Kategorie') {
                    final categoryId = event.row.cells['id']?.value ?? '';
                    final selectedCategory = categoryList.firstWhere(
                      (cat) => cat.id == categoryId,
                      orElse:
                          () => ChecklistCategoryModel(
                            id: '',
                            name: '',
                            appgroupId: '',
                            appgroupName: '',
                            checklists: [],
                          ),
                    );
                    Navigator.pushNamed(
                      context,
                      AppRoutes.checklist,
                      arguments: {
                        'categoryId': categoryId,
                        'checklists': selectedCategory.checklists,
                      },
                    );
                  }
                },
              ),
    );
  }
}
