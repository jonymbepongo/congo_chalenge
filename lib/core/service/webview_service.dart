import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../webview/webview_injector.dart';


class WebViewService {
  static WebViewController createController(String url) {
    // 🔹 Initialisation plateforme
    if (WebViewPlatform.instance == null) {
      if (Platform.isIOS || Platform.isMacOS) {
        WebViewPlatform.instance = WebKitWebViewPlatform();
      } else {
        WebViewPlatform.instance = AndroidWebViewPlatform();
      }
    }

    // 🔹 Création des paramètres
    late final PlatformWebViewControllerCreationParams params;

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    // 🔹 Création controller
    final controller =
        WebViewController.fromPlatformCreationParams(params);

    // 🔹 Options Android spécifiques
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    // 🔹 Configuration générale
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            WebViewInjector.injectHideNavbarAndFooter(controller);
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return controller;
  }
}