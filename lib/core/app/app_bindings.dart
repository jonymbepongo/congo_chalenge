import 'package:congo_chalenge/core/app/app_name.dart';
import 'package:congo_chalenge/core/service/api_service.dart';

import 'package:congo_chalenge/feature/auth/repository/auth_repository.dart';
import 'package:congo_chalenge/feature/auth/controller/auth_controller.dart';

import 'package:congo_chalenge/feature/webview/controller/webview_getx_controller.dart';
import 'package:congo_chalenge/feature/webview/service/webview_service_mode_app.dart';

import 'package:get/get.dart';

class AppBindings extends Bindings {

  @override
  void dependencies() {

    /// ===============================
    /// 🔹 SERVICES CORE
    /// ===============================

    Get.lazyPut<ApiService>(
      () => ApiService(),
      fenix: true,
    );

    Get.lazyPut<WebViewServiceModeApp>(
      () => WebViewServiceModeApp(),
      fenix: true,
    );



    /// ===============================
    /// 🔹 REPOSITORIES
    /// ===============================

    Get.lazyPut<AuthRepository>(
      () => AuthRepository(Get.find<ApiService>()),
      fenix: true,
    );



    /// ===============================
    /// 🔹 CONTROLLERS
    /// ===============================

    Get.put<AuthController>(
  AuthController(Get.find<AuthRepository>(), Get.find<ApiService>()),
  permanent: true,
);



    /// ===============================
    /// 🔹 WEBVIEW CONTROLLER
    /// ===============================

    // Get.put<WebGetXController>(
    //   WebGetXController(AppName.url),
    //   permanent: true,
    // );
  }
}