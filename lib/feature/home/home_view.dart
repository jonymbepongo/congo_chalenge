import 'package:congo_chalenge/core/app/app_colors.dart';
import 'package:congo_chalenge/feature/artiste/controller/artiste_controller.dart';
import 'package:congo_chalenge/feature/artiste/widget/artiste_card.dart';
import 'package:congo_chalenge/feature/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/home_carrousel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthController controller = Get.find<AuthController>();
  final ArtisteController artisteController = Get.find<ArtisteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body:Obx(() {
    final user=controller.user;
    // final roles=controller.roles;

  // if (user == null ||user.isEmpty) {
  //   return const CircularProgressIndicator();
  // }

  return 
      Stack(
        children:[
          AppBar(
            backgroundColor: AppColor.background,
            title: Text('Bienvenue  ${user['username'] ?? 'jony'}' ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  controller.logout();
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: const Icon(Icons.notifications),
                ),
              ),
            ],
          ), 
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                
                // Carousel
                const HomeCarousel(),
                          
                const SizedBox(height: 16),
                          
                // Container "S'inscrire au Challenge"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Voulez-vous participer à la compétition ?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Inscrivez-vous dès maintenant et montrez votre talent au monde entier.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFC107),
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "S'INSCRIRE AU CHALLENGE",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                          
                const SizedBox(height: 24),
                          
                // Section Artistes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'LES ARTISTES',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Voir tout',
                          style: TextStyle(color: Color(0xFFFFC107)),
                        ),
                      ),
                    ],
                  ),
                ),
                          
                // Grid des Artistes
                Obx(() {
          final controller=artisteController;

        /// 🔄 Loading
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        /// ❌ Aucun artiste
        if (controller.artistes.isEmpty) {
          return const Center(
            child: Text("Aucun artiste disponible"),
          );
        }

        /// ✅ Liste artistes
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
        
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        
            crossAxisCount: 2,
        
            crossAxisSpacing: 12,
        
            mainAxisSpacing: 12,
        
            childAspectRatio: 0.75,
        
          ),
        
          itemCount: controller.artistes.length,
        
          itemBuilder: (context, index) {
        
            final artiste = controller.artistes[index];
        
            return ArtistCard(
              artiste: artiste,
            );
        
          },
        );
      }),
                          
                const SizedBox(height: 24),
              ],
                          ),
            ),
          ),
      ]);
    }));
  }
}