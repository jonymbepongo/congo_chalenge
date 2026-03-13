import 'package:congo_chalenge/feature/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  bool loading = false;

  void handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await authController.login(
        email: emailController.text,
        password: passwordController.text,
      );
      
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Connexion réussie")));

      // Navigator.pushReplacement(...);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          // Email / username
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email ou pseudo",
              prefixIcon: Icon(Icons.mail),
            ),
            validator: (value) => value!.isEmpty ? "Champ requis" : null,
          ),
          const SizedBox(height: 16),

          // Password
          TextFormField(
            controller: passwordController,
            obscureText: !showPassword,
            decoration: InputDecoration(
              labelText: "Mot de passe",
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () => setState(() => showPassword = !showPassword),
              ),
            ),
            validator: (value) => value!.isEmpty ? "Champ requis" : null,
          ),
          const SizedBox(height: 16),

          // Submit
          Obx(
            () => ElevatedButton(
              onPressed: authController.isLoading.value ? null : handleLogin,

              child: authController.isLoading.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text("Se connecter"),
            ),
          ),
        ],
      ),
    );
  }
}
