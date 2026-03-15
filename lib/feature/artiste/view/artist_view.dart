import 'package:congo_chalenge/feature/artiste/widget/artiste_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/artiste_controller.dart';

class ArtistView extends StatelessWidget {
  ArtistView({super.key});

    final ArtisteController controller = Get.find<ArtisteController>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Candidats"),
        centerTitle: true,
      ),

      body: Obx(() {

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
        return RefreshIndicator(

          onRefresh: () => controller.fetchArtists(),

          child: GridView.builder(
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
          ),
        );
      }),
    );
  }
}