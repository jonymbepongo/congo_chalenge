import 'package:congo_chalenge/core/app/app_name.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({Key? key}) : super(key: key);

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  int _current = 0;
  // Correction ici : Utilisation de CarouselSliderController
  final CarouselSliderController _carouselController = CarouselSliderController();

  final List<Map<String, String>> imgList = [
    {
      'title': 'ÉDITION SPÉCIALE 2026',
      'label': 'LIVE NOW',
      'image': AppName.ImageHero,
    },
    {
      'title': 'VOTEZ POUR VOTRE STAR',
      'label': 'EN COURS',
      'image': AppName.ImageHero,
    },
    {
      'title': 'FINALE À KINSHASA',
      'label': 'BIENTÔT',
      'image': AppName.ImageHero,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imgList.length,
          carouselController: _carouselController,
          itemBuilder: (context, index, realIndex) {
            return _buildCarouselCard(imgList[index]);
          },
          options: CarouselOptions(
            height: 200-60,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            autoPlay: true, // Activé selon la doc pour plus de dynamisme
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        const SizedBox(height: 12),
        // Indicateurs personnalisés
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _current == entry.key ? 24.0 : 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: _current == entry.key 
                      ? const Color(0xFFFFC107) 
                      : Colors.white.withOpacity(0.2),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCarouselCard(Map<String, String> data) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(data['image']!),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC107),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                data['label']!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              data['title']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}