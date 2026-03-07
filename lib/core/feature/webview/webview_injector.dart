import 'package:webview_flutter/webview_flutter.dart';

class WebViewInjector {

  static void injectHideNavbarAndFooter(WebViewController controller) {
    controller.runJavaScript(_hideScript);
  }

  static const String _hideScript = '''
(function() {

  function hideElements() {

    // Navbar
    var navbar = document.getElementById("navbar");
    if (navbar) {
      navbar.style.display = "none";
    }

    // Footer
    var footer = document.querySelector("footer");
    if (footer) {
      footer.style.display = "none";
    }

    // Mobile bottom nav (class md:hidden)
    var mobileNav = document.querySelector("nav.md\\\\:hidden");
    if (mobileNav) {
      mobileNav.style.display = "none";
    }

    // Supprimer padding du body si header fixed
    document.body.style.paddingTop = "0px";

  }

  hideElements();

  // Observer React DOM changes
  const observer = new MutationObserver(function() {
      hideElements();
  });

  observer.observe(document.body, {
      childList: true,
      subtree: true
  });

})();
''';
}

// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewInjector {
//   static void injectHideNavbarAndFooter(WebViewController controller) {
//     controller.runJavaScript(_hideScript);
//   }

//   static const String _hideScript = '''
//     (function() {
//       function hideElements() {
//         var navbar = document.getElementById("navbar");
//         if (navbar) navbar.style.display = "none";

//         var footer = document.querySelector("footer");
//         if (footer) footer.style.display = "none";
//       }

//       hideElements();

//       const observer = new MutationObserver(hideElements);
//       observer.observe(document.body, { childList: true, subtree: true });
//     })();
//   ''';
// }