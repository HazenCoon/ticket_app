import 'package:flutter/material.dart';
import 'package:test1/core/routing/app_routes.dart';
import 'package:test1/features/presentation/theme/app_theme.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/presentation/screens/ticket_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
      theme: appTheme,

      // Statische Routen
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.tickets: (context) => const TicketGrid(),
        AppRoutes.checklist: (context) => const ChecklistScreen(),
      },

      // Dynamische Routen
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
