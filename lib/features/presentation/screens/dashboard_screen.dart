import 'package:flutter/material.dart';

import '../../ticket/presentation/screens/ticket_screen.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: Colors.lightBlue,
          titleTextStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Willkommen im Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Button für die Navigation
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TicketGrid()),
                );
              },
              child: const Text('Zur Ticket-Tabelle'),
            ),
          ],
        ),
      ),
    );
  }
}
