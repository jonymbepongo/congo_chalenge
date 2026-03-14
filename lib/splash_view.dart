import 'dart:async';

import 'package:congo_chalenge/feature/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'core/app/app_colors.dart';
import 'core/app/app_name.dart';



class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    startApp();
    // Timer(const Duration(seconds: 5), ()=>Get.offAll(()=>AuthPage()));
    
  }

void startApp() async {

    // attendre un peu pour afficher le splash
    await Future.delayed(const Duration(seconds: 3));

    // vérifier si utilisateur connecté
    await authController.checkAuthStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ 
          
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(AppName.ImageConcert),
               fit: BoxFit.cover)
            )
          ),
          Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8),
            // gradient: LinearGradient(
            //   // center: Alignment.topLeft,
            //   // radius: 0.8,
            //   colors: [
            //     const Color.fromARGB(255, 1, 11, 29).withValues(alpha: 0.9),// Centre plus clair/accentué
            //     const Color.fromARGB(255, 8, 4, 48).withValues(alpha: 0.3), // Bords plus foncés
            //   ],
            //   stops: const [0.2, 1.0],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   tileMode: TileMode.mirror
            //   // tileMode: TileMode.mirror,
            //   // focalRadius: 5
            // ),
            // Dégradé radial circulaire comme demandé
            // gradient: RadialGradient(
            //   center: Alignment.topLeft,
            //   radius: 0.8,
            //   colors: [
            //     const Color.fromARGB(255, 12, 61, 145).withValues(alpha: 0.9),// Centre plus clair/accentué
            //     Colors.black.withValues(alpha: 0.3), // Bords plus foncés
            //   ],
            //   stops: const [0.2, 1.0],
            //   // tileMode: TileMode.mirror,
            //   focalRadius: 5
            // ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Espacement supérieur
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.26,
                  // ),
                  // Contenu principal centré
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(AppName.ImageLogo),fit: BoxFit.fill),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.secondary.withValues(alpha: 0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    // child: Icon(
                    //   Icons.mic, // Icône micro
                    //   size: 50,
                    //   color: AppColor.primary,
                    // ),
                  ),
                  
                  const SizedBox(height: 40),
                  const Text(
                    'Bienvenue',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColor.secondary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
        
                  // Texte d'accueil "Bienvenue dans le Royaume de la Musique!"
                  const Text(
                    'dans la compétition Congo chalenge league !',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
      
                  buildSpanText()
                  
                  // Message secondaire en lien avec le workflow
                  
                 
        
                  
                  // Bouton "Profitez de la musique maintenant >"
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 20),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Action à définir : navigation vers la page suivante
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: AppColor.secondary,
                  //       foregroundColor: Colors.white,
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 30,
                  //         vertical: 12,
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       elevation: 5,
                  //     ),
                  //     child: const Text(
                  //       'Decouvrez des nouvelles talents',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
        
                
                  
                  // Bas de page avec le lien vers les conditions
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 20.0),
                  //   child: Column(
                  //     children: [
                  //       const Text(
                  //         'Ou lisez et acceptez le',
                  //         style: TextStyle(
                  //           color: Colors.white70,
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //       const SizedBox(height: 4),
                  //       GestureDetector(
                  //         onTap: () {
                  //           // Action : ouvrir les conditions d'utilisation
                  //         },
                  //         child: const Text(
                  //           'Contrat de licence d\'utilisateur final & Politique de confidentialité',
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.bold,
                  //             decoration: TextDecoration.underline,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
       
          Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: DrapeurCouleur()),
          Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: DrapeurCouleur())
      ]),
    );
  }
}

Widget buildSpanText() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic
      ),
      children: [
        TextSpan(
          text: 'Femme ',
          style: TextStyle(color: AppColor.secondary),
        ),
        TextSpan(
          text: ' - ',
          style: TextStyle(color: Colors.white70),
        ),
        TextSpan(
          text: 'Paix ',
          style: TextStyle(color: Colors.blue),
        ),
        TextSpan(
          text: ' - ',
          style: TextStyle(color: Colors.white70),
        ),
        TextSpan(
          text: 'Résilience',
          style: TextStyle(color: const Color.fromARGB(255, 237, 18, 18)),
        ),
      ],
    ),
  );
}

class DrapeurCouleur extends StatelessWidget {
  final double height;
  final double width;
  final Color? firstColor;
  final Color? secondColor;
  final Color? thirdColor;
  
  const DrapeurCouleur({
    super.key,
    this.height = 3,
    this.width = 60,
    this.firstColor,
    this.secondColor,
    this.thirdColor,
  });

  @override
  Widget build(BuildContext context) {
    // Couleurs par défaut
    
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Premier conteneur - AppColor.secondary
          Expanded(
            child: Container(
              color: AppColor.secondary,
            ),
          ),
          
          // Deuxième conteneur - Colors.blue
          Expanded(
            child: Container(
              color:Colors.blue,
            ),
          ),
          
          // Troisième conteneur - Color.fromARGB(255, 237, 18, 18)
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 237, 18, 18),
            ),
          ),
        ],
      ),
    );
  }
}