import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFF4CAF50);     // Vert plus vif pour le contraste
  static const Color primaryDark = Color(0xFF2E7D32); 
  static const Color accent = Color(0xFFFFB300);      // Or pour les trophées et boutons d'action

  // 🌑 Thème Sombre (Le Coeur de l'application)
  static const Color background = Color.fromARGB(255, 9, 3, 86);  // Fond principal (très sombre)
  static const Color surface = Color(0xFF1E1E1E);     // Fond des cartes, dialogues, inputs
  static const Color card = Color(0xFF252525);        // Légère élévation pour les listes d'artistes

  // ⚪ Typographie (Haute visibilité)
  static const Color textMain = Color(0xFFFFFFFF);    // Blanc pur pour les titres
  static const Color textSecondary = Color(0xFFB0B0B0); // Gris clair pour les sous-titres
  static const Color textDisabled = Color(0xFF6E6E6E);  // Pour les éléments inactifs

  // 🚦 Statuts (Workflow de validation FESTIRAS)
  static const Color success = Color(0xFF81C784);     // Vert pastel (plus doux sur fond noir)
  static const Color error = Color(0xFFE57373);       // Rouge pastel
  static const Color pending = Color(0xFFFFB74D);     // Orange pastel
  
  // 🛠 Bordures et Diviseurs
  static const Color border = Color(0xFF333333);      // Gris foncé pour séparer sans agresser
}