import 'package:flutter/material.dart';
import 'package:test1/features/checklist_category/presentation/screens/checklist_category_screen.dart';
import 'package:test1/features/presentation/screens/dashboard_screen.dart';

class MyAppRoutes {
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const tickets = '/tickets';
  static const checklistCategory = '/checklistCategory';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        final String accessToken = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DashboardScreen(accessToken: accessToken),
        );
      case checklistCategory:
        final String token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ChecklistCategoryScreen(token: token),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  Scaffold(body: Center(child: Text('Route nicht gefunden.'))),
        );
    }
  }
}
