import 'package:quotes_app/models/categories_model.dart';

class LocalJsonModel {
  String jsonData;
  List<CategoryModel> categories;

  LocalJsonModel({
    required this.jsonData,
    required this.categories,
  });
}
