import 'package:congo_chalenge/core/app/app_colors.dart';
import 'package:congo_chalenge/feature/artiste/model/artiste_model.dart';
import 'package:congo_chalenge/feature/artiste/controller/artiste_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistCard extends StatelessWidget {

  final ArtisteModel artiste;

  ArtistCard({super.key, required this.artiste});

  final ArtisteController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    final voted = controller.hasVoted(artiste.id);

    return LayoutBuilder(
      builder: (context, constraints) {

        final width = constraints.maxWidth;
        final imageHeight = width * 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: artiste.photoUrl != null
                      ? NetworkImage(artiste.photoUrl!)
                      : const AssetImage('assets/artist-1.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [

                  Positioned(
                    top: 8,
                    right: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Row(
                          children: [
                            const Icon(Icons.person, color: Colors.blue, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              artiste.totalVotes.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            const Icon(Icons.favorite, color: Colors.red, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              artiste.scoreFinal.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            artiste.nomArtiste.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Row(
                            children: [
                              Text(
                                artiste.discipline,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '• ${artiste.ville ?? ""}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {

                  controller.vote(artiste.id);

                },
                icon: Icon(
                    voted ? Icons.thumb_up : Icons.check_circle_outline,
                    size: 16),
                label: Text(
                  voted ? 'Liker' : 'Voter',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      voted ? Colors.blue : AppColor.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

          ],
        );
      },
    );
  }
}