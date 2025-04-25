import 'package:flutter/material.dart';
import 'package:test1/core/network/api_client.dart';
import 'package:test1/features/checklist_category/data/models/checklist_category_model.dart';
import 'package:test1/features/checklist_category/data/services/checklist_category_service.dart';

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
  // State & Initialisierung
  late Future<List<ChecklistCategoryModel>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = _loadCategories();
  }

  // API-Aufruf mit Token
  Future<List<ChecklistCategoryModel>> _loadCategories() async {
    final dio = await ApiClient.getClient(token: widget.token);
    final service = ChecklistCategoryService(dio);
    return await service.fetchChecklistCategories(widget.token);
  }

  // UI mit FutureBuilder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checklist-Kategorien')),
      body: FutureBuilder<List<ChecklistCategoryModel>>(
        future: _futureCategories,
        builder: (context, snapshot) {
          // Ladeanzeige
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Fehleranzeige
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Fehler beim Laden: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _futureCategories = _loadCategories();
                      });
                    },
                    child: const Text('Erneut versuchen'),
                  ),
                ],
              ),
            );
          }

          // Datenanzeige
          final categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              // Darstellung der Kategorien
              return ExpansionTile(
                title: Text(category.name),
                children:
                    category.checklists
                        .map(
                          (checklist) => ListTile(title: Text(checklist.name)),
                        )
                        .toList(),
              );
            },
          );
        },
      ),
    );
  }
}
