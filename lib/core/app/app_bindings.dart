import 'package:congo_chalenge/core/app/app_name.dart';
import 'package:congo_chalenge/feature/webview/controller/webview_getx_controller.dart';
import 'package:congo_chalenge/feature/webview/service/webview_service_mode_app.dart';
import 'package:get/get.dart';


// Services Core (WebView, stockage, etc.)

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // 🔹 Services Core globaux
  
    Get.lazyPut<WebViewServiceModeApp>(() => WebViewServiceModeApp(), fenix: true);
    
    
    //le controller injecté
    
    Get.put<WebGetXController>(WebGetXController(AppName.url),permanent: true);


    // Exemple : tu pourrais ajouter d’autres controllers ou services comme dans ton AppBindings initial
    /* 
    Get.lazyPut<UserService>(() => UserService(), fenix: true);
    Get.put<AuthController>(AuthController(Get.find<UserService>(), Get.find<StorageService>()), permanent: true);
    */
  }
}