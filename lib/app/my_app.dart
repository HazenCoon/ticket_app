import 'package:flutter/material.dart';
import 'package:test1/app/routing/app_routes.dart';
import '../core/ui/theme/app_theme.dart';

/// Einstiegspunkt der App mit zentraler MaterialApp-Konfiguration.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
      theme: appTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.staticRoutes,
      onGenerateRoute: AppRoutes.generateRoute, // für dynamische Routen
    );
  }
}
