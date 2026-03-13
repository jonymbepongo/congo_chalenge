import 'package:congo_chalenge/core/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/app/app_bindings.dart';
import 'core/app/app_colors.dart';
import 'core/app/app_name.dart';
import 'core/app/routes.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService();
  await apiService.checkBackendConnection();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppName.appName,
      debugShowCheckedModeBanner: false,
      
      // Injection des dépendances (WebViewService, WebGetXController, etc.)
      initialBinding: AppBindings(),
      
      // Gestion des routes centralisée
      getPages: AppRoutes.routes,
      initialRoute: AppRoutes.initial, // Point d'entrée défini dans tes routes
      
      // Configuration du Thème Nuit (Dark Mode)
      themeMode: ThemeMode.dark, // Force l'application en mode sombre
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        
        scaffoldBackgroundColor: AppColor.background, 
        
        colorScheme: const ColorScheme.dark(
          primary: AppColor.primary,
          secondary: AppColor.accent, 
          surface: AppColor.background, // Définit la surface par défaut sur le background
          error: AppColor.error,
          onSurface: AppColor.textMain,
        ),

        // Configuration globale de l'AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.background, // Couleur identique au scaffold
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.textMain),
          titleTextStyle: TextStyle(
            color: AppColor.textMain,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Configuration globale de la BottomNavigationBar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColor.background, // Couleur identique au scaffold
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.textSecondary,
          elevation: 0, // Optionnel : retire l'ombre pour un look "flat" très moderne
          type: BottomNavigationBarType.fixed,
        ),

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColor.textMain),
          bodyMedium: TextStyle(color: AppColor.textSecondary),
        ),
      ),
    );
  }
}