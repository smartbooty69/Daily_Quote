import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/controllers/image_capture_controller.dart';
import 'package:quotes_app/utils/globals.dart';

class BackGroundThemePage extends StatefulWidget {
  const BackGroundThemePage({super.key});

  @override
  State<BackGroundThemePage> createState() => _BackGroundThemePageState();
}

class _BackGroundThemePageState extends State<BackGroundThemePage> {
  ImageCaptureController imageCaptureController =
      Get.find<ImageCaptureController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.01),
        child: GridView.builder(
          itemCount: backGroundImages.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: height * 0.015,
            mainAxisSpacing: height * 0.015,
            childAspectRatio: 6 / 9,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                imageCaptureController.backGroundImage(
                    bgImage: backGroundImages[index]);
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(height * 0.01)),
                  image: DecorationImage(
                    image: AssetImage(backGroundImages[index]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
