import 'package:congo_chalenge/core/widget/custom_textfied.dart';
import 'package:congo_chalenge/feature/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmView extends StatefulWidget {
  const ConfirmView({super.key});

  @override
  State<ConfirmView> createState() => _ConfirmViewState();
}

class _ConfirmViewState extends State<ConfirmView> {

  final AuthController authController = Get.find<AuthController>();

  final TextEditingController codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late String email;

  @override
  void initState() {
    super.initState();

    email = Get.arguments["email"];
  }

  void handleVerify() async {

    if (!_formKey.currentState!.validate()) return;

    await authController.verifyEmail(
      email: email,
      code: codeController.text,
    );
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [

          /// gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF3F6FD6),
                  Color.fromARGB(255, 1, 19, 58),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Positioned(
            top: height * 0.15,
            left: 20,
            right: 20,
            child: Column(
              children: [

                const Text(
                  "Confirmation",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Un code a été envoyé dans votre mail.\nVeuillez vérifier votre boite mail.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
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
                      children: [

                        CustomTextField(
                          controller: codeController,
                          labelText: "Code de confirmation",
                          hintText: "Entrez le code",
                          icon: Icons.lock,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Entrez le code";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 25),

                        Obx(() => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: authController.isLoading.value
                                ? null
                                : handleVerify,
                            child: authController.isLoading.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text("Confirmer"),
                          ),
                        )),

                      ],
                    ),
                  ),
                )

              ],
            ),
          )

        ],
      ),
    );
  }
}