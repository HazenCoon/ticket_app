import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/routing/app_routes.dart';

// Klasse DashboardScreen
class DashboardScreen extends StatefulWidget {
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

            // Button für die Navigation zur TicketGrid
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.tickets);
              },
              child: const Text('Zur Ticket-Tabelle'),
            ),

            SizedBox(height: 30),

            // Button für die Navigation zur ChecklistCategory
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
                    SnackBar(content: Text('Kein Token gefunden')),
                  );
                }
              },
              child: Text('Zu den Checklist-Kategorien'),
            ),
          ],
        ),
      ),
    );
  }
}
