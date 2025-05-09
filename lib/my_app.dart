import 'package:flutter/material.dart';
import 'package:test1/features/presentation/theme/app_theme.dart';
import 'package:test1/core/routing/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
      theme: appTheme,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.staticRoutes,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
