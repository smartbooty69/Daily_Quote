import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotes_app/models/categories_model.dart';
import 'package:quotes_app/models/json_model.dart';

class JsonController extends GetxController {
  LocalJsonModel localJsonModel = LocalJsonModel(jsonData: "", categories: []);

  Future<List<CategoryModel>> localJsonDecode() async {
    String path = "lib/resources/json/quotes.json";
    localJsonModel.jsonData = await rootBundle.loadString(path);

    List decodedList = jsonDecode(localJsonModel.jsonData);

    localJsonModel.categories =
        decodedList.map((e) => CategoryModel.fromMap(e)).toList();

    return localJsonModel.categories;
  }
}
