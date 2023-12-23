import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/utils/globals.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Get.offNamed("/homePage");
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/other_images/logo.png",
              height: height * 0.32,
              width: height * 0.32,
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Text(
              "Quotes",
              style: TextStyle(
                fontSize: height * 0.036,
                fontWeight: FontWeight.bold,
                color: const Color(0xff244049),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
