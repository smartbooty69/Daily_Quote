import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes_app/models/categories_database_model.dart';
import 'package:quotes_app/models/favorite_database_model.dart';
import 'package:quotes_app/models/quotes_database_model.dart';

double height = Get.height;
double width = Get.width;

final getStorage = GetStorage();

late Future<List<CategoryDatabaseModel>> fetchAllCategory;

int? quoteId;
String? categoryName;
String? categoryImage;

late Future<List<QuotesDatabaseModel>> allQuotes;
late Future<List<QuotesDatabaseModel>> quote;

late Future<List<FavoriteDataBaseModel>> favoriteQuotes;

List<String> backGroundImages = [
  "assets/images/category_images/1.png",
  "assets/images/category_images/2.png",
  "assets/images/category_images/3.png",
  "assets/images/category_images/4.png",
  "assets/images/category_images/5.png",
  "assets/images/category_images/6.png",
  "assets/images/category_images/7.png",
  "assets/images/category_images/8.png",
  "assets/images/category_images/9.png",
  "assets/images/category_images/10.png",
  "assets/images/category_images/11.png",
  "assets/images/category_images/12.png",
  "assets/images/category_images/13.png",
  "assets/images/category_images/14.png",
  "assets/images/category_images/15.png",
  "assets/images/category_images/16.png",
  "assets/images/category_images/17.png",
  "assets/images/category_images/18.png",
  "assets/images/category_images/19.png",
  "assets/images/category_images/20.png",
  "assets/images/category_images/21.png",
  "assets/images/category_images/22.png",
  "assets/images/category_images/23.png",
  "assets/images/category_images/24.png",
  "assets/images/category_images/25.png",
  "assets/images/category_images/26.png",
  "assets/images/category_images/27.png",
  "assets/images/category_images/28.png",
  "assets/images/category_images/29.png",
  "assets/images/category_images/30.png",
  "assets/images/category_images/31.png",
  "assets/images/category_images/32.png",
  "assets/images/category_images/33.png",
  "assets/images/category_images/34.png",
  "assets/images/category_images/35.png",
  "assets/images/category_images/36.png",
  "assets/images/category_images/37.png",
  "assets/images/category_images/38.png",
  "assets/images/category_images/39.png",
  "assets/images/category_images/40.png",
  "assets/images/category_images/41.png",
  "assets/images/category_images/42.png",
  "assets/images/category_images/43.png",
  "assets/images/category_images/44.png",
  "assets/images/category_images/45.png",
  "assets/images/category_images/46.png",
  "assets/images/category_images/47.png",
  "assets/images/category_images/48.png",
];
