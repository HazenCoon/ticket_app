import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/core/errors/app_exception.dart';
import 'package:test1/core/errors/dio_error_handler.dart';
import 'package:test1/core/network/api_client.dart';
import '../../../../app/routing/app_routes.dart';

// LoginScreen Widget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// Zustand & Controller
class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Methode zum Speichern des Tokens
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // Login-Methode
  void _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    // Anzeige von Ladeindikator, Fehler zurücksetzen
    try {
      final token = await ApiClient.authenticate(
        _usernameController.text,
        _passwordController.text,
      );

      // Benutzername und Passwort werden an die API geschickt
      await saveToken(token);

      // Routing zum Dashboard
      if (mounted) {
        Navigator.pushNamed(context, AppRoutes.dashboard, arguments: token);
      }

      // Fehler wird in _error gespeichert
    } on DioException catch (e) {
      final exception = handleDioError(e);
      setState(() {
        _error =
            exception is AppException
                ? exception.message
                : 'Ein unbekannter Fehler ist aufgetreten.';
      });
    } catch (e) {
      setState(() {
        _error = 'Ein unerwarteter Fehler ist aufgetreten.';
      });

      // Ladeanimation wird auf false gesetzt
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(labelText: 'Benutzername'),
          onChanged: (_) => setState(() {}),
        ),

        const SizedBox(height: 10),

        TextField(
          controller: _passwordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _login(),
          decoration: const InputDecoration(labelText: 'Passwort'),
          onChanged: (_) => setState(() {}),
        ),

        const SizedBox(height: 20),

        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(_error!, style: const TextStyle(color: Colors.red)),
          ),

        if (_loading)
          const Center(child: CircularProgressIndicator())
        else
          ElevatedButton(
            onPressed:
                _usernameController.text.isEmpty ||
                        _passwordController.text.isEmpty
                    ? null
                    : _login,
            child: const Text('Login'),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anmeldung')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildLoginForm(),
      ),
    );
  }
}
