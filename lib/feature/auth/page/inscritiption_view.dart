import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class InscriptionView extends StatefulWidget {
  const InscriptionView({super.key});

  @override
  State<InscriptionView> createState() => _InscriptionViewState();
}

class _InscriptionViewState extends State<InscriptionView> {
  final AuthController controller = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword = false;
  bool loading = false;

  void handleLogin() async {

  if (!_formKey.currentState!.validate()) return;

  try {

    await controller.login(
      email: emailController.text,
      password: passwordController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Connexion réussie")),
    );

    // Navigator.pushReplacement(...);

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );

  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Username
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Nom d'utilisateur",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value!.isEmpty ? "Champ requis" : null,
              ),
              const SizedBox(height: 16),
                
              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.mail),
                ),
                validator: (value) => value!.isEmpty ? "Champ requis" : null,
              ),
              const SizedBox(height: 16),
                
              // Phone
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: "Téléphone",
                  prefixIcon: Icon(Icons.phone),
                ),
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
                    icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => showPassword = !showPassword),
                  ),
                ),
                validator: (value) => value!.isEmpty ? "Champ requis" : null,
              ),
              const SizedBox(height: 16),
                
              // Confirm Password
              TextFormField(
                controller: confirmPasswordController,
                obscureText: !showPassword,
                decoration: const InputDecoration(
                  labelText: "Confirmer le mot de passe",
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) => value!.isEmpty ? "Champ requis" : null,
              ),
              const SizedBox(height: 16),
                
              // Submit
              Obx(() => ElevatedButton(
                
          onPressed: controller.isLoading.value
          ? null
          : handleLogin,
                
          child: controller.isLoading.value
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : const Text("Se connecter"),
                
                ))
            ],
          ),
        ),
      ),
    );
  }
}