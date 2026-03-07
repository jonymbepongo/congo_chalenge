import 'package:congo_chalenge/core/app/app_name.dart';
import 'package:congo_chalenge/core/feature/webview/controller/web_getx_controller.dart';
import 'package:get/get.dart';
import '../feature/webview/service/webview_service.dart';

// Services Core (WebView, stockage, etc.)

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // 🔹 Services Core globaux
  
    Get.lazyPut<WebViewService>(() => WebViewService(), fenix: true);
    
    
    //le controller injecté
    
    Get.put<WebGetXController>(WebGetXController(AppName.url),permanent: true);


    // Exemple : tu pourrais ajouter d’autres controllers ou services comme dans ton AppBindings initial
    /* 
    Get.lazyPut<UserService>(() => UserService(), fenix: true);
    Get.put<AuthController>(AuthController(Get.find<UserService>(), Get.find<StorageService>()), permanent: true);
    */
  }
}