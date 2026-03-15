import 'package:congo_chalenge/core/app/app_colors.dart';
import 'package:congo_chalenge/core/widget/custom_textfied.dart';
import 'package:congo_chalenge/feature/auth/controller/auth_controller.dart';
import 'package:congo_chalenge/feature/auth/page/inscritiption_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widget/media_signin.dart';

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

  void handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await authController.login(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {}
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
            top: height * 0.10,
            left: 20,
            right: 20,
            child: Column(
              children: [
                const Text(
                  "Connexion",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),

                const Text(
                  "Connecetez-vous pour rejoindre la compétition",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 25),
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
                        const SizedBox(height: 30),

                        CustomTextField(
                          controller: emailController,
                          labelText: "Email ou téléphone",
                          hintText: "exemple@email.com",
                          icon: Icons.person,
                          margin: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Entrez votre email";
                            }
                            return null;
                          },
                        ),
                    const SizedBox(height: 20),
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

                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(
                              color: AppColor.secondary,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Bouton login
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: authController.isLoading.value
                                  ? null
                                  : handleLogin,
                              child: authController.isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text("Se connecter"),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),
                      mediaSignIn("OU CONTINUER AVEC"),
                        /// Divider OU
                        // Row(
                        //   children: const [
                        //     Expanded(
                        //       child: Divider(
                        //         color: Colors.white24,
                        //         thickness: 1,
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.symmetric(horizontal: 10),
                        //       child: Text(
                        //         "OU",
                        //         style: TextStyle(
                        //           color: Colors.white54,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Divider(
                        //         color: Colors.white24,
                        //         thickness: 1,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        const SizedBox(height: 30),

                        /// Mot de passe oublié

                        /// Inscription
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Vous n'avez pas de compte ? ",
                              style: TextStyle(color: Colors.white70),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(()=> const InscriptionView());
                              },
                              child: const Text(
                                "S'inscrire",
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