import 'package:flutter/material.dart';
import 'package:test1/features/auftrag/domain/models/auftrag_checklist_model.dart';
import 'package:test1/features/auftrag/presentation/screens/auftrag_screen.dart';
import 'package:test1/features/checklist_category/domain/models/checklist_model.dart';
import 'package:test1/features/checklist_category/presentation/screens/checklist_category_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/checklist_category/checklist/presentation/checklist_screen.dart';
import '../../features/presentation/screens/dashboard_screen.dart';
import '../../features/presentation/screens/ticket_screen.dart';
import 'package:test1/features/auftrag/presentation/screens/auftrag_checklist_screen.dart';

class AppRoutes {
  static const String checklist = '/checklist';
  static const String dashboard = '/dashboard';
  static const String checklistCategory = '/checklistCategory';
  static const String login = '/login';
  static const String tickets = '/tickets';
  static const String auftragchecklists = '/auftragChecklists';
  static const String auftraege = '/auftraege';

  /// Statische Routen
  static Map<String, WidgetBuilder> get staticRoutes => {
    login: (context) => const LoginScreen(),
    tickets: (context) => const TicketGrid(),
  };

  /// Dynamische Routen
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case checklist:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null) {
          debugPrint('Fehler: Keine Argumente übergeben');
          return _errorRoute();
        }
        final categoryId = args['categoryId'] as String;
        final checklists = args['checklists'] as List<ChecklistModel>;
        return MaterialPageRoute(
          builder:
              (context) => ChecklistScreen(
                categoryId: categoryId,
                checklists: checklists,
              ),
        );

      case auftragchecklists:
        final args = settings.arguments as List<AuftragChecklistModel>;
        return MaterialPageRoute(
          builder: (context) => AuftragChecklistScreen(checklists: args),
        );

      case dashboard:
        final String token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => DashboardScreen(accessToken: token),
        );

      case checklistCategory:
        final String token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ChecklistCategoryScreen(token: token),
        );

        case auftraege:
        final String token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => AuftragScreen(token: token),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (context) =>
              const Scaffold(body: Center(child: Text('Route nicht gefunden'))),
    );
  }
} 
