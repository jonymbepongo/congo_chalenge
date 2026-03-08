import 'package:get/get.dart';

import '../../splash_view.dart';

class AppRoutes {
  static const String initial = '/';

  static const String accueil = '/accueil';
  static const String competition = '/competition';
  static const String artiste = '/artiste';
  static const String profil = '/profil';
  static const String admin = '/administration';

  static List<GetPage> routes = [
    // La page initiale charge la WebView principale
    GetPage(
      name: initial,
      page: () => const SplashView(),
      transition: Transition.fadeIn,
    ),

    // Ces routes permettent de naviguer vers des sections précises du site web
    /*GetPage(
      name: accueil,
      page: () => const WebViewScreen(),
      transition: Transition.noTransition,
    ),
    
    GetPage(
      name: competition,
      page: () => const WebViewScreen(),
      transition: Transition.noTransition,
    ),

    GetPage(
      name: artiste,
      page: () => const WebViewScreen(),
      transition: Transition.noTransition,
    ),

    GetPage(
      name: profil,
      page: () => const WebViewScreen(),
      transition: Transition.cupertino, // Animation plus "App" pour le profil
    ),

    GetPage(
      name: admin,
      page: () => const WebViewScreen(),
      transition: Transition.rightToLeft,
    ),*/
  ];
}