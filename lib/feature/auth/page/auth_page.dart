import 'package:congo_chalenge/feature/auth/page/inscritiption_view.dart';
import 'package:flutter/material.dart';
import 'login_view.dart';

enum AuthMode { login, signup }

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthMode mode = AuthMode.login;

  void switchMode(AuthMode newMode) {
    setState(() {
      mode = newMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Image.asset(
              'assets/hero-bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6), // gradient overlay
          ),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Congo Chalenge',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Tab Switcher
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text('Connexion'),
                      selected: mode == AuthMode.login,
                      onSelected: (_) => switchMode(AuthMode.login),
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey.shade800,
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    ChoiceChip(
                      label: const Text('Inscription'),
                      selected: mode == AuthMode.signup,
                      onSelected: (_) => switchMode(AuthMode.signup),
                      selectedColor: Colors.blue,
                      backgroundColor: Colors.grey.shade800,
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Form
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: mode == AuthMode.login
                        ? const LoginView()
                        : const InscriptionView(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}