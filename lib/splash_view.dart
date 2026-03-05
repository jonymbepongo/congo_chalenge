import 'dart:async';

import 'package:congo_chalenge/my_web_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),()=>Get.to(()=>MyWebView()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 8, 120, 211),
            const Color.fromARGB(255, 1, 25, 61),          
          ],
          tileMode: TileMode.mirror,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height:90,
              width: 90,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              color: Colors.blue.withValues(alpha: 0.8),
              ),
              child: Icon(Icons.library_music_rounded,color: Colors.red.shade600,size: 50,)),
            SizedBox(height: 10),
            Center(
              child: Text("Congo\nchalenge",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}