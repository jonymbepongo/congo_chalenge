import 'package:flutter/material.dart';

class BodyArrondi extends StatelessWidget {
  final Widget content;

  const BodyArrondi({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(25),
      ),
      child: Container(
        color: Colors.white,
        child: content,
      ),
    );
  }
}