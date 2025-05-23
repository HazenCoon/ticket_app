import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/routing/app_routes.dart';

/// DashboardScreen zeigt Einstiegsmöglichkeiten für Tickets,
/// Checklistenkategorien und Auftrags-Checklisten.
class DashboardScreen extends StatefulWidget {
  /// Zugriffstoken, der beim Login empfangen wurde.
  final String accessToken;

  const DashboardScreen({super.key, required this.accessToken});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// Klasse _DashboardScreenState
class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.lightBlue,
        titleTextStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Willkommen im Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),

            /// Button für die Ticket-Tabelle.
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.tickets);
              },
              child: const Text('Zur Ticket-Tabelle'),
            ),

            SizedBox(height: 30),

            /// Button zu den Checklist-Kategorien mit Token aus SharedPreferences.
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final token = prefs.getString('access_token');
                if (!context.mounted) return;
                if (token != null) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.checklistCategory,
                    arguments: token,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fehler beim Lesen des Tokens'),
                    ),
                  );
                }
              },
              child: Text('Zu den Checklist-Kategorien'),
            ),

            SizedBox(height: 30),

            /// Button zu den Auftrags-Checklisten mit Token aus SharedPrefences.
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final token = prefs.getString('access_token');
                if (!context.mounted) return;
                if (token != null) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.auftraege,
                    arguments: token,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fehler beim Lesen des Tokens'),
                    ),
                  );
                }
              },
              child: const Text('Zu den Auftrags-Checklisten'),
            ),
          ],
        ),
      ),
    );
  }
}
