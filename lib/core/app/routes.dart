import 'package:congo_chalenge/bottom_nav_bar_page.dart';
import 'package:congo_chalenge/feature/artiste/view/artist_view.dart';
import 'package:congo_chalenge/feature/auth/page/login_view.dart';
import 'package:congo_chalenge/feature/home/home_view.dart';
import 'package:get/get.dart';

import '../../splash_view.dart';

class AppRoutes {
  static const String initial = '/';
  static const String bottomNavBar = '/bottom-nav-bar';
  static const String login = '/login';
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
    GetPage(
      name: bottomNavBar,
      page: () => const BottomNavBarPage(index: 0,),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: accueil,
      page: () => const HomeView(),
      transition: Transition.rightToLeft,
    ),
    
    GetPage(
      name: login,
      page: () => const LoginView(),
      transition: Transition.noTransition,
    ),

    GetPage(
  name: AppRoutes.artiste,
  page: () => ArtistView(),
  transition: Transition.rightToLeft
),

    /*GetPage(
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