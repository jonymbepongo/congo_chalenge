import 'package:flutter/material.dart';

Widget mediaSignIn(String texte) {
  return Column(
    children: [

      const SizedBox(height: 20),

      Row(
        children: [
          Expanded(child: Divider(color: Colors.white24)),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 10),
            child:  Text(
              texte ,
              style: TextStyle(color: Colors.white54),
            ),
          ),
          Expanded(child: Divider(color: Colors.white24)),
        ],
      ),

      const SizedBox(height: 20),

      Row(
        children: [

          /// Google
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.g_mobiledata, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Google",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 15),

          /// Facebook
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Facebook",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ],
  );
}