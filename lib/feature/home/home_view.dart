import 'package:congo_chalenge/feature/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Accueil")),
      body:Obx(() {

  if (controller.user.isEmpty) {
    return const CircularProgressIndicator();
  }

  return Column(
    children: [

      Text("Username : ${controller.user["username"]}"),

      Text("Email : ${controller.user["email"]}"),

      Text("Role : ${controller.roles.join(", ")}"),

    ],
  );
})
    );
  }
}
