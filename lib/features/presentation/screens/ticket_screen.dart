import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../data/ticket_table_data.dart';


class TicketGrid extends StatefulWidget {
  const TicketGrid({super.key});

  @override
  State<TicketGrid> createState() => _TicketGridState();
}

class _TicketGridState extends State<TicketGrid> {
  late final PlutoGridStateManager stateManager;

  @override
  void initState() {
    super.initState();
    for (var column in columns) {
      column.enableSorting = true;
      column.titleTextAlign = PlutoColumnTextAlign.center;
      column.titleSpan = TextSpan(
        text: column.title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Skillsoftware Tickets'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        titleTextStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
      body: Column(
        children: [
          Divider(color: Colors.black, thickness: 2, height: 3),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(22),
              color: Colors.grey,
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                mode: PlutoGridMode.multiSelect,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  stateManager.setShowColumnFilter(true);
                },
                onChanged: (PlutoGridOnChangedEvent event) {
                 if (kDebugMode) {
                   print(event);
                 }
                },
                configuration: const PlutoGridConfiguration(),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Zurück zum Dashboard'),
              ),
            ),
        ],
      ),
    );
  }
}