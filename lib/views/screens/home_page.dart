// ignore_for_file: unused_import

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:quotes_app/views/components/favorite_page.dart';
import 'package:quotes_app/views/components/setting_page.dart';

import '../../controllers/image_capture_controller.dart';
import '../../models/categories_database_model.dart';
import '../../utils/globals.dart';
import '../../utils/helpers/dbHelper.dart';
import '../components/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> searchCategoryFormKey = GlobalKey<FormState>();
  TextEditingController searchCategoryController = TextEditingController();
  bool launchAnimation = false;

  ImageCaptureController imageCaptureController =
      Get.put(ImageCaptureController());
  @override
  void initState() {
    super.initState();
    fetchAllCategory = DBHelper.dbHelper.fetchAllCategory();
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
            icon: Icon(Icons.favorite_outline),
          ),
        ],
        title: const Text("Quotes"),
        centerTitle: true,
      ),
      body: Form(
        key: searchCategoryFormKey,
        child: Padding(
          padding: EdgeInsets.all(height * 0.016),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: TextFormField(
                    controller: searchCategoryController,
                    onChanged: (value) {
                      setState(() {
                        fetchAllCategory =
                            DBHelper.dbHelper.fetchSearchCategory(data: value);
                      });
                    },
                    scrollPhysics: const BouncingScrollPhysics(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search...",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(width * 0.08),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            searchCategoryController.clear();
                            fetchAllCategory =
                                DBHelper.dbHelper.fetchAllCategory();
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder(
                future: fetchAllCategory,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<CategoryDatabaseModel>? data = snapshot.data;
                    if (data == null || data.isEmpty) {
                      return Center(
                        child: Image.asset(
                          "assets/images/other_images/no_data.png",
                          height: height * 0.35,
                          width: height * 0.35,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: AnimationLimiter(
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 5 / 6,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  Get.toNamed("/categoryPage");
                                  categoryName = data[index].categoryName;
                                  categoryImage = data[index].categoryImage;
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            height * 0.008),
                                      ),
                                      child: Container(
                                        height: height * 0.19,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                data[index].categoryIcon),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      data[index].categoryName,
                                      style: TextStyle(
                                        fontSize: height * 0.024,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  }
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
