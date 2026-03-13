import 'package:congo_chalenge/core/app/app_model.dart';
import 'package:congo_chalenge/core/app/routes.dart';
import 'package:get/get.dart';
import 'package:congo_chalenge/core/service/api_service.dart';
import 'package:congo_chalenge/core/utils/logger.dart';

import '../../../core/app/app_colors.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;
  final ApiService api;
  AuthController(this.repository,this.api);

  RxBool isLoading = false.obs;
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  RxMap user = {}.obs;
  RxList<String> roles = <String>[].obs;
  

  

  Future<void> checkAuthStatus() async {
    final token = await api.getToken();

    if (token != null) {
      // Si un token existe, on récupère le profil
      await getProfile();

      // Redirection vers HomeView
      Get.offAllNamed(AppRoutes.accueil);
      AppLogger.log("Utilisateur déjà connecté, redirection vers HomeView");
    } else {
      // Sinon, redirection vers LoginView
      Get.offAllNamed(AppRoutes.login);
      AppLogger.log("Aucun utilisateur connecté, redirection vers LoginView");
    }
  }

  Future<void> login({required String email, required String password}) async {
    isLoading.value = true;
    try {
      final response = await repository.login(email: email, password: password);

      final token = response["data"]["token"];
      final userData = response["data"]["user"];
      final rolesData = response["data"]["roles"];

      await ApiService().saveToken(token);

      // Désérialisation en UserModel
      currentUser.value = UserModel.fromJson(userData);

      Get.offAllNamed(AppRoutes.accueil);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  /// LOGIN
  // Future<void> login({
  //   required String email,
  //   required String password,
  // }) async {

  //   isLoading.value = true;

  //   try {

  //     final response = await repository.login(
  //       email: email,
  //       password: password,
  //     );

  //     /// BACKEND RESPONSE
  //     /// {
  //     /// user:{},
  //     /// token:"",
  //     /// roles:[]
  //     /// }

  //     final token = response["data"]["token"];
  //     final userData = response["data"]["user"];

  //     /// SAVE TOKEN
  //     await ApiService().saveToken(token);

  //     /// SAVE USER
  //     user.value = userData;
  //     Get.snackbar("Succès", "Connexion réussie", snackPosition: SnackPosition.TOP,backgroundColor: AppColor.success);
  //     Get.offAllNamed(AppRoutes.accueil);
  //     AppLogger.log("Utilisateur connecté");

  //   } catch (e) {

  //     AppLogger.error("Erreur login controller: $e");
  //     Get.snackbar("Erreur", "Échec de la connexion : ${e.toString()}",
  //     snackPosition: SnackPosition.TOP,backgroundColor: AppColor.error);

  //     rethrow;

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

      AppLogger.log("Profil chargé : $userData");

    }

  } catch (e) {
    AppLogger.log("Erreur getProfile: $e");
  }
}

  /// LOGOUT

  Future<void> logout() async {
    await ApiService().clearToken();

    currentUser.value = null;

    AppLogger.log("Utilisateur déconnecté");
  }
}
