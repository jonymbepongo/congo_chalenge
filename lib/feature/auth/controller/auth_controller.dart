import 'package:congo_chalenge/core/app/routes.dart';
import 'package:get/get.dart';
import 'package:congo_chalenge/core/service/api_service.dart';
import 'package:congo_chalenge/core/utils/logger.dart';

import '../../../core/app/app_colors.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {

  final AuthRepository repository;

  AuthController(this.repository);

  RxBool isLoading = false.obs;

  RxMap user = {}.obs;

  /// LOGIN
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

      /// BACKEND RESPONSE
      /// {
      /// user:{},
      /// token:"",
      /// roles:[]
      /// }

      final token = response["data"]["token"];
      final userData = response["data"]["user"];

      /// SAVE TOKEN
      await ApiService().saveToken(token);

      /// SAVE USER
      user.value = userData;
      Get.snackbar("Succès", "Connexion réussie", snackPosition: SnackPosition.TOP,backgroundColor: AppColor.success);
      Get.offAllNamed(AppRoutes.accueil);     
      AppLogger.log("Utilisateur connecté");

    } catch (e) {

      AppLogger.error("Erreur login controller: $e");
      Get.snackbar("Erreur", "Échec de la connexion : ${e.toString()}", 
      snackPosition: SnackPosition.TOP,backgroundColor: AppColor.error);
  

      rethrow;

    } finally {

      isLoading.value = false;
    }
  } 

  /// GET PROFILE

  Future<void> getProfile() async {

    try {

      final response = await repository.getProfile();

      user.value = response["data"];

    } catch (e) {

      AppLogger.error("Erreur profile: $e");

    }
  }

  /// LOGOUT

  Future<void> logout() async {

    await ApiService().clearToken();

    user.clear();

    AppLogger.log("Utilisateur déconnecté");

  }
}