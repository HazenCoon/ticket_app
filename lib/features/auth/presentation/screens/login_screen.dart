import 'package:flutter/material.dart';

import '../../../presentation/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  // Controller für E-Mail und Password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwortController = TextEditingController();

  // GlobalKey für das Formular
  final _formKey = GlobalKey<FormState>();

  // Variable zum Steuern der Anzeige 'Passwort anzeigen'
  bool _obscureText = true;

  // Dummy-Funktion für das Anmelden
  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      //Implementierung der Anmeldelogik
      final email = _usernameController.text;
      final passwort = _passwortController.text;

      if (email == 'user@example.com' && passwort == 'passwort') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Erfolgreich eingeloggt')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Ungültige Anmeldedaten')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      appBar: AppBar(
        title: Text('Anmeldung'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        titleTextStyle: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 600,
            constraints: BoxConstraints(minHeight: 450),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 76),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // E-Mail Eingabefeld
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-Mail',
                      hintText: 'Bitte geben Sie Ihre E-Mail-Adresse ein',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte geben Sie Ihre E-Mail-Adresse ein';
                      }
                      // E-Mail-Validierung
                      if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      ).hasMatch(value)) {
                        return 'Bitte geben Sie eine gültige E-Mail-Adresse ein';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  //Passwort Eingabefeld
                  TextFormField(
                    controller: _passwortController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Passwort',
                      hintText: 'Bitte geben Sie Ihr Passwort ein',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte geben Sie Ihr Passwort ein';
                      }
                      if (value.length < 8) {
                        return 'Das Passwort muss mindestens 8 Zeichen lang sein';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  // Login-Button
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: const Text('Anmelden'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
