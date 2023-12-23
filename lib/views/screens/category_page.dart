import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quotes_app/controllers/image_capture_controller.dart';
import 'package:quotes_app/models/favorite_database_model.dart';
import 'package:quotes_app/models/quotes_database_model.dart';
import 'package:quotes_app/utils/globals.dart';
import 'package:quotes_app/utils/helpers/dbHelper.dart';
import 'package:share_extend/share_extend.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  ImageCaptureController imageCaptureController =
      Get.find<ImageCaptureController>();

  @override
  void initState() {
    super.initState();
    allQuotes = DBHelper.dbHelper.fetchAllQuotes(categoryName: categoryName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/favoritePage");
            },
            icon: const Icon(Icons.favorite_outline),
          ),
        ],
        centerTitle: true,
        title: Text(
          categoryName!,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(height * 0.016),
        child: FutureBuilder(
          future: allQuotes,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error : ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              List<QuotesDatabaseModel>? data = snapshot.data;

              if (data == null || data.isEmpty) {
                return Center(
                  child: Image.asset(
                    "assets/images/other_images/no_data.png",
                    height: height * 0.35,
                    width: height * 0.35,
                  ),
                );
              } else {
                List<GlobalKey> screenshotGlobalKey =
                    List.generate(data.length, (index) => GlobalKey());
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...List.generate(
                        data.length,
                        (index) => Column(
                          children: [
                            RepaintBoundary(
                              key: screenshotGlobalKey[index],
                              child: GestureDetector(
                                onTap: () async {
                                  quoteId = data[index].quoteId;
                                  imageCaptureController.backGroundImage(
                                      bgImage: categoryImage!);
                                  Get.toNamed("/quoteDetailsPage");
                                },
                                child: Container(
                                  height: height * 0.35,
                                  width: width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(categoryImage!),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(height * 0.008),
                                      topRight: Radius.circular(height * 0.008),
                                    ),
                                  ),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.all(height * 0.014),
                                            child: Text(
                                              '“ ${data[index].quote} ”',
                                              style: TextStyle(
                                                fontSize: height * 0.03,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.068,
                              width: width,
                              margin: EdgeInsets.only(bottom: height * 0.016),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(height * 0.008),
                                  bottomRight: Radius.circular(height * 0.008),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: height * 0.016,
                                  right: height * 0.016,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (data[index].isFavorite == 0) {
                                          DBHelper.dbHelper
                                              .insertFavoriteQuotes(
                                            data: FavoriteDataBaseModel(
                                              quoteId: data[index].quoteId,
                                              quoteCategory:
                                                  data[index].quoteCategory,
                                              quote: data[index].quote,
                                              quoteAuthor:
                                                  data[index].quoteAuthor,
                                              quoteImage: categoryImage!,
                                            ),
                                          );

                                          allQuotes = DBHelper.dbHelper
                                              .fetchAllQuotes(
                                                  categoryName: categoryName!);
                                          setState(() {});
                                        } else {
                                          DBHelper.dbHelper
                                              .deleteFromFavoriteQuote(
                                            quoteId: data[index].quoteId,
                                            quoteCategory:
                                                data[index].quoteCategory,
                                          );

                                          allQuotes = DBHelper.dbHelper
                                              .fetchAllQuotes(
                                                  categoryName: categoryName!);
                                          setState(() {});
                                        }
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          (data[index].isFavorite == 0)
                                              ? const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.favorite,
                                                  color: Colors.pink,
                                                ),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          const Text(
                                            "Like",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        imageCaptureController
                                            .captureImage(
                                                screenshotGlobalKey:
                                                    screenshotGlobalKey[index])
                                            .then(
                                              (value) => Get.snackbar(
                                                "Saved",
                                                "Image saved successfully in gallery...",
                                              ),
                                            );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.download,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          const Text(
                                            "Save",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                              text: data[index].quote),
                                        );
                                        Fluttertoast.showToast(
                                          msg: "Copied",
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.copy,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          const Text(
                                            "Copy",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        String filePath =
                                            await imageCaptureController
                                                .shareImage(
                                                    screenshotGlobalKey:
                                                        screenshotGlobalKey[
                                                            index],
                                                    data: data[index]);
                                        ShareExtend.share(filePath, "image");
                                        //Share.shareFiles([(filePath)]);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.share,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          const Text(
                                            "Share",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
