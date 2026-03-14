// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// import '../core/app/app_name.dart';
// import 'core/widget/body_arrondi.dart';
// import 'feature/webview/controller/webview_getx_controller.dart';

// class MyWebView extends StatelessWidget {

//   MyWebView({super.key});

//   // final WebGetXController controller =
//   //     Get.put(WebGetXController(AppName.url));

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Bienvenue"),
//         centerTitle: true,
//       ),

//       body: BodyArrondi(
        
//   content: Obx(() {

//     /// pas internet
//     if (!controller.hasInternet.value) {
//       return _noInternet();
//     }

//     /// erreur chargement
//     if (controller.hasError.value) {
//       return _error();
//     }

//     return Stack(
//       children: [

//         WebViewWidget(
//           controller: controller.webController,
//         ),

//         if (controller.isLoading.value)
//           const Center(
//             child: CircularProgressIndicator(),
//           ),
//       ],
//     );
//   }),
// ),
//     );
//   }

//   Widget _noInternet() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [

//           const Icon(Icons.wifi_off, size: 80),

//           const SizedBox(height: 20),

//           const Text(
//             "Pas de connexion internet",
//             style: TextStyle(fontSize: 18),
//           ),

//           const SizedBox(height: 20),

//           ElevatedButton(
//             onPressed: controller.reloadPage,
//             child: const Text("Recharger"),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _error() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [

//           const Icon(Icons.error_outline, size: 80),

//           const SizedBox(height: 20),

//           const Text(
//             "Impossible de charger la page",
//             style: TextStyle(fontSize: 18),
//           ),

//           const SizedBox(height: 20),

//           ElevatedButton(
//             onPressed: controller.reloadPage,
//             child: const Text("Réessayer"),
//           )
//         ],
//       ),
//     );
//   }
// }