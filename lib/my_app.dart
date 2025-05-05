import 'package:flutter/material.dart';
import 'package:test1/features/checklist_category/presentation/screens/checklist_category_screen.dart';
import 'package:test1/features/presentation/theme/app_theme.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/checklist/presentation/checklist_screen.dart';
import 'features/presentation/screens/dashboard_screen.dart';
import 'features/presentation/screens/ticket_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
      theme: appTheme,

      // Statische Routen
      initialRoute: MyAppRoutes.login,
      routes: {
        MyAppRoutes.login: (context) => const LoginScreen(),
        MyAppRoutes.tickets: (context) => const TicketGrid(),
      },

      // Dynamische Routen
      onGenerateRoute: MyAppRoutes.generateRoute,
    );
  }
}

class MyAppRoutes {
  static const String checklist = '/checklist';
  static const String dashboard = '/dashboard';
  static const String checklistCategory = '/checklistCategory';
  static const String login = '/login';
  static const String tickets = '/tickets';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case checklist:
        final args = settings.arguments as Map<String, dynamic>;
        final categoryId = args['categoryId'] as String;
        final checklists = args['checklists'] as List<dynamic>;
        return MaterialPageRoute(
          builder: (context) => ChecklistScreen(
              categoryId: categoryId,
            checklists: checklists,
          ),
        );
      case dashboard:
        final token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => DashboardScreen(accessToken: token),
        );
      case checklistCategory:
        final token = settings.arguments;
        if (token is String) {
          return MaterialPageRoute(
            builder: (context) => ChecklistCategoryScreen(token: token),
          );
        } else {
          return MaterialPageRoute(builder: (context) => const LoginScreen());
        }
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}
