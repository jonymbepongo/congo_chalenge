import 'package:congo_chalenge/core/app/app_colors.dart';
import 'package:flutter/material.dart';

class ArtistCard extends StatefulWidget {
  const ArtistCard({Key? key}) : super(key: key);

  @override
  State<ArtistCard> createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  bool _voted = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Largeur disponible
        final width = constraints.maxWidth;
        // Hauteur de l'image proportionnelle à la largeur
        final imageHeight = width * 0.7;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image + badges + stats
            Container(
              height: imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/artist-1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Badges
                  // Positioned(
                  //   top: 8,
                  //   left: 8,
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 8, vertical: 4),
                  //         decoration: BoxDecoration(
                  //           color: Colors.red,
                  //           borderRadius: BorderRadius.circular(16),
                  //         ),
                  //         child: const Text(
                  //           'Rap',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(width: 4),
                  //       Container(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 8, vertical: 4),
                  //         decoration: BoxDecoration(
                  //           color: Colors.black54,
                  //           borderRadius: BorderRadius.circular(16),
                  //         ),
                  //         child: const Text(
                  //           'Kindu',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Stats
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.blue, size: 12),
                            SizedBox(width: 2),
                            Text('0',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.red, size: 12),
                            SizedBox(width: 2),
                            Text('22',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Nom + genre + ville + barre de progression
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PETIT FALLY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text('Rap',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12)),
                      const SizedBox(width: 4),
                      Text('• Kindu',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const LinearProgressIndicator(
                      value: 0.1,
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Bouton Voter / Liker
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _voted = !_voted;
                    });
                  },
                  icon: Icon(_voted ? Icons.thumb_up : Icons.check_circle_outline,
                      size: 16),
                  label: Text(_voted ? 'Liker' : 'Voter',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _voted ? Colors.blue : AppColor.secondary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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