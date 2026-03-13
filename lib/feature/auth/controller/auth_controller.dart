import 'package:congo_chalenge/bottom_nav_bar_page.dart';
import 'package:congo_chalenge/core/app/app_model.dart';
import 'package:congo_chalenge/core/app/routes.dart';
import 'package:congo_chalenge/core/service/cache_service.dart';
import 'package:get/get.dart';
import 'package:congo_chalenge/core/service/api_service.dart';
import 'package:congo_chalenge/core/utils/logger.dart';

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
    Get.offAll(() => const BottomNavBarPage(index: 0));

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

    Get.offAllNamed(AppRoutes.accueil);

  } catch (e) {

    rethrow;

  } finally {

    isLoading.value = false;

  }

}


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
