import 'package:congo_chalenge/core/app/app_colors.dart';
import 'package:congo_chalenge/core/widget/custom_textfied.dart';
import 'package:congo_chalenge/feature/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widget/media_signin.dart';

class InscriptionView extends StatefulWidget {
  const InscriptionView({super.key});

  @override
  State<InscriptionView> createState() => _InscriptionViewState();
}

class _InscriptionViewState extends State<InscriptionView> {
  final AuthController authController = Get.find<AuthController>();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await authController.register(
        username: usernameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      );
    } catch (e) {}
  }
Widget espace(){
  return const SizedBox(height: 5);
}
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          /// Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3F6FD6), Color.fromARGB(255, 1, 19, 58)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// Form container
          Positioned(
            top: height * 0.07,
            left: 15,
            right: 15,
            child: Column(
              children: [
                const Text(
                  "Inscription",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                const Text(
                  "Créez votre compte pour participer",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A1B3F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Username
                        CustomTextField(
                          controller: usernameController,
                          labelText: "Nom d'utilisateur",
                          hintText: "Votre nom",
                          icon: Icons.person,
                          margin: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Entrez votre nom";
                            }
                            return null;
                          },
                        ),

                        espace(),

                        /// Email
                        CustomTextField(
                          controller: emailController,
                          labelText: "Email",
                          hintText: "exemple@email.com",
                          icon: Icons.email,
                          margin: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Entrez votre email";
                            }
                            return null;
                          },
                        ),

                        espace(),

                        /// Phone
                        CustomTextField(
                          controller: phoneController,
                          labelText: "Téléphone",
                          hintText: "+243...",
                          icon: Icons.phone,
                          margin: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Entrez votre numéro";
                            }
                            return null;
                          },
                        ),

                        espace(),

                        /// Password
                        CustomTextField(
                          controller: passwordController,
                          labelText: "Mot de passe",
                          hintText: "********",
                          icon: Icons.lock,
                          obscureText: true,
                          margin: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Entrez votre mot de passe";
                            }
                            return null;
                          },
                        ),

                        espace(),
                        /// Confirm password
                        CustomTextField(
                          controller: confirmPasswordController,
                          labelText: "Confirmer mot de passe",
                          hintText: "********",
                          icon: Icons.lock,
                          obscureText: true,
                          margin: 5,
                          validator: (value) {
                            if (value != passwordController.text) {
                              return "Les mots de passe ne correspondent pas";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        /// Bouton inscription
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: authController.isLoading.value
                                  ? null
                                  : handleRegister,
                              child: authController.isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text("S'inscrire"),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        mediaSignIn('OU S\'INSSCRIR AVEC'),

                        const SizedBox(height: 15),

                        /// Retour connexion
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Vous avez déjà un compte ? ",
                              style: TextStyle(color: Colors.white70),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Text(
                                "Se connecter",
                                style: TextStyle(
                                  color: AppColor.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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