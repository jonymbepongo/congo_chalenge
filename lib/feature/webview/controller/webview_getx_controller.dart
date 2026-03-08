import 'dart:async';

import 'package:congo_chalenge/feature/webview/service/webview_service_mode_app.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class WebGetXController extends GetxController {
  
  late WebViewController webController;

  final String url;

  WebGetXController(this.url);

  /// états
  var isLoading = true.obs;
  var hasError = false.obs;
  var hasInternet = true.obs;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _initWebView();
  }

  /// initialisation WebView
  void _initWebView() {

    webController = WebViewServiceModeApp.createController(url);

    webController.setNavigationDelegate(
      NavigationDelegate(

        onPageStarted: (url) {
          isLoading.value = true;
        },

        onPageFinished: (url) {
          isLoading.value = false;
          hasError.value = false;
        },

        onWebResourceError: (error) {

          /// seulement si la page principale échoue
          if (error.isForMainFrame == true) {
            isLoading.value = false;
            hasError.value = true;
          }

        },

      ),
    );
  }

  /// détection internet
  void _initConnectivity() async {

    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);

    _subscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {

    if (result.contains(ConnectivityResult.none)) {
      hasInternet.value = false;
    } else {

      /// internet revenu
      if (!hasInternet.value) {
        reloadPage();
      }

      hasInternet.value = true;
    }
  }

  /// reload
  void reloadPage() {
    hasError.value = false;
    isLoading.value = true;
    webController.reload();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}