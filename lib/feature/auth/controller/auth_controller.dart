import 'package:congo_chalenge/core/app/app_model.dart';
import 'package:congo_chalenge/core/app/routes.dart';
import 'package:congo_chalenge/core/service/cache_service.dart';
import 'package:get/get.dart';
import 'package:congo_chalenge/core/service/api_service.dart';
import 'package:congo_chalenge/core/utils/logger.dart';

import '../../../core/app/app_colors.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  final ApiService api;
  final CacheService cache;
  AuthController(this.repository,this.api,this.cache);

  RxBool isLoading = false.obs;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  RxMap user = {}.obs;
  RxList<String> roles = <String>[].obs;
  

  

Future<void> checkAuthStatus() async {

  final token = await api.getToken();

  if (token != null) {

    final cachedUser = cache.getCache("user");
    final cachedRoles = cache.getCache("roles");

    if (cachedUser != null) {
      user.value = Map<String, dynamic>.from(cachedUser);
    }

    if (cachedRoles != null) {
      roles.value = List<String>.from(cachedRoles);
    }

    // Get.offAllNamed(AppRoutes.accueil);
    Get.offAllNamed(AppRoutes.bottomNavBar);

  } else {

    Get.offAllNamed(AppRoutes.login);

  }
}

Future<void> login({
  required String email,
  required String password,
}) async {

  isLoading.value = true;

  try {

    final response = await repository.login(
      email: email,
      password: password,
    );

    final token = response["data"]["token"];
    final userData = response["data"]["user"];
    final rolesData = response["data"]["roles"];

    final api = Get.find<ApiService>();
    final cache = Get.find<CacheService>();

    /// SAVE TOKEN
    await api.saveToken(token);

    /// USER MODEL
    currentUser.value = UserModel.fromJson(userData);

    /// ROLES
    roles.value = List<String>.from(rolesData);

    /// SAVE CACHE
    await cache.saveCache("user", userData);
    await cache.saveCache("roles", rolesData);

    Get.offAllNamed(AppRoutes.bottomNavBar);

  } catch (e) {

    Get.snackbar("probleme", e.toString());

    rethrow;

  } finally {

    isLoading.value = false;

  }

}
// Future<void> register({
//   required String username,
//   required String email,
//   required String phone,
//   required String password,
// }) async {

//   isLoading.value = true;

//   try {

//     final response = await repository.register({
//       "username": username,
//       "email": email,
//       "phone": phone,
//       "password": password,
//     });

//     if (response["success"] == true) {

//       final emailResponse = response["data"]["email"];

//       /// navigation vers confirm view
//       Get.toNamed(
//         AppRoutes.confirmEmail,
//         arguments: {
//           "email": emailResponse,
//         },
//       );

//     }

//   } catch (e) {

//     Get.snackbar(
//       "Erreur inscription",
//       e.toString(),
//       snackPosition: SnackPosition.BOTTOM,
//     );
//     AppLogger.error("Erreur inscription: $e");

//   } finally {

//     isLoading.value = false;

//   }
Future<void> register({
  required String username,
  required String email,
  required String phone,
  required String password,
}) async {
  isLoading.value = true;

  try {
    final response = await repository.register({
      "username": username,
      "email": email,
      "phone": phone,
      "password": password,
    });

    if (response["success"] == true) {
      // stocker temporairement email et mot de passe pour login auto après verification
      await cache.saveCache("temp_email", email);
      await cache.saveCache("temp_password", password);

      final emailResponse = response["data"]["email"];

      // navigation vers confirm view
      Get.toNamed(
        AppRoutes.confirmEmail,
        arguments: {"email": emailResponse},
      );
    }

  } catch (e) {
    Get.snackbar("Erreur inscription", e.toString(), snackPosition: SnackPosition.BOTTOM);
    AppLogger.error("Erreur inscription: $e");
  } finally {
    isLoading.value = false;
  }
}

Future<void> verifyEmail({
  required String email,
  required String code,
}) async {
  isLoading.value = true;

  try {
    final response = await repository.verifyEmail(
      email: email,
      code: code,
    );

    if (response['success'] == true) {
      final emailVerified = response['verificationStatus']['email']['verified'] ?? false;
       final phoneVerified = response['verificationStatus']['phone']['verified'] ?? false;
      if (emailVerified) {
        // Récupérer email et mot de passe temporaire
        final tempEmail = await cache.getCache("temp_email");
        final tempPassword = await cache.getCache("temp_password");

        if (tempEmail != null && tempPassword != null) {
          // LOGIN automatique
          await login(email: tempEmail, password: tempPassword);
          AppLogger.log("Login automatique après vérification réussie");

          // Supprimer les infos temporaires
          await cache.removeCache("temp_email");
          await cache.removeCache("temp_password");
        } else {
          // si pas dispo, rediriger vers login
          Get.offAllNamed(AppRoutes.login);
          Get.snackbar("Info", "Email vérifié, veuillez vous connecter.");
          AppLogger.error("Vérification réussie mais infos temporaires manquantes");
        }
      } else {
        Get.snackbar("Erreur", "Email non vérifié.");
        AppLogger.error("Vérification échouée: email non vérifié");
      }

    } else {
      Get.snackbar("Erreur", response['message'] ?? "Erreur inconnue");
    }

  } catch (e) {
    Get.snackbar("Erreur", e.toString());
    AppLogger.error("Erreur vérification email: $e");
  } finally {
    isLoading.value = false;
  }
}

// Future<void> verifyEmail({
//   required String email,
//   required String code,
// }) async {
//   isLoading.value = true;

//   try {
//     final response = await repository.verifyEmail(
//       email: email,
//       code: code,
//     );

//     // vérifier si la requête a réussi
//     if (response['success'] == true) {
//       final emailVerified = response['verificationStatus']['email']['verified'] ?? false;
//      final phoneVerified = response['verificationStatus']['phone']['verified'] ?? false;

//       if (emailVerified) {
//         // Naviguer vers l'écran principal ou la suite
//         Get.offAllNamed(AppRoutes.bottomNavBar);
//         Get.snackbar(
//           "Succès",
//           'Bienvenue dans la compétition !',
//           backgroundColor: AppColor.primary,
//           snackPosition: SnackPosition.TOP,
//         );
//       } else {
//         Get.snackbar("Erreur", "Email non vérifié.");
//       }
//     } else {
//       Get.snackbar("Erreur", response['message'] ?? "Erreur inconnue");
//     }

//   } catch (e) {
//     Get.snackbar("Erreur", e.toString());
//     AppLogger.error("Erreur vérification email: $e");
//   } finally {
//     isLoading.value = false;
//   }
// }


  /// GET PROFILE
Future<void> getProfile() async {

  try {

    final response = await repository.getProfile();

    if (response["success"] == true) {

      final userData = response["data"]["user"];
      final rolesData = response["data"]["roles"];

      user.value = userData;
      roles.value = List<String>.from(rolesData);

      /// SAVE CACHE
      await cache.saveCache("user", userData);
      await cache.saveCache("roles", rolesData);

      AppLogger.log("Profil chargé : $userData");

    }

  } catch (e) {

    AppLogger.log("Erreur getProfile: $e");

  }

}

  /// LOGOUT

 Future<void> logout() async {

  final api = Get.find<ApiService>();
  final cache = Get.find<CacheService>();

  await api.clearToken();
  await cache.clearAll();

  currentUser.value = null;
  roles.clear();

  Get.offAllNamed(AppRoutes.login);

  }
}
