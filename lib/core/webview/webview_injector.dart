import 'package:webview_flutter/webview_flutter.dart';

class WebViewInjector {
  static void injectHideNavbarAndFooter(WebViewController controller) {
    controller.runJavaScript(_hideScript);
  }

  static const String _hideScript = '''
    (function() {
      function hideElements() {
        var navbar = document.getElementById("navbar");
        if (navbar) navbar.style.display = "none";

        var footer = document.querySelector("footer");
        if (footer) footer.style.display = "none";
      }

      hideElements();

      const observer = new MutationObserver(hideElements);
      observer.observe(document.body, { childList: true, subtree: true });
    })();
  ''';
}