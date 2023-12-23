import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/models/image_capture_model.dart';
import 'package:quotes_app/models/quotes_database_model.dart';

class ImageCaptureController extends GetxController {
  ImageCaptureModel imageCaptureModel =
      ImageCaptureModel(backGroundImage: "".obs);

  Future captureImage({required GlobalKey screenshotGlobalKey}) async {
    final RenderRepaintBoundary boundary = screenshotGlobalKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage();

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    await ImageGallerySaver.saveImage(pngBytes.buffer.asUint8List());
  }

  Future<String> shareImage(
      {required GlobalKey screenshotGlobalKey,
      required QuotesDatabaseModel data}) async {
    final RenderRepaintBoundary boundary = screenshotGlobalKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage();

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file =
        await File("${tempDir.path}/${data.quoteCategory}.jpg").create();
    file.writeAsBytesSync(pngBytes);

    return file.path;
  }

  void backGroundImage({required String bgImage}) {
    imageCaptureModel.backGroundImage = bgImage.obs;
    update();
  }
}
