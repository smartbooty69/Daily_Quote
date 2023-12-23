import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:quotes_app/models/quotes_model.dart';

class CategoryModel {
  int id;
  String categoryName;
  Uint8List icon;
  Uint8List image;
  List<QuoteModel> quotes;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.icon,
    required this.image,
    required this.quotes,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> data) => CategoryModel(
        id: data["category-id"],
        categoryName: data["quotes-category"],
        icon: Uint8List.fromList(data["category-icon"].codeUnits),
        image: Uint8List.fromList(data["category-image"].codeUnits),
        quotes: List<QuoteModel>.from(
          data["quotes"].map(
            (quote) => QuoteModel.fromMap(quote),
          ),
        ),
      );
}
