// ignore_for_file: file_names, unused_local_variable

import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:quotes_app/controllers/database_check_controller.dart';
import 'package:quotes_app/controllers/json_controller.dart';
import 'package:quotes_app/models/categories_database_model.dart';
import 'package:quotes_app/models/categories_model.dart';
import 'package:quotes_app/models/favorite_database_model.dart';
import 'package:quotes_app/models/quotes_database_model.dart';
import 'package:quotes_app/utils/globals.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  Future<void> initDB() async {
    String dbLocation = await getDatabasesPath();

    String path = join(dbLocation, "Quotes.db");

    db = await openDatabase(path, version: 1, onCreate: (db, _) async {
      String query1 =
          "CREATE TABLE IF NOT EXISTS categories(category_id INTEGER, category_name TEXT NOT NULL, category_icon BLOB, category_image BLOB);";
      String query2 =
          "CREATE TABLE IF NOT EXISTS quotes(quote_id INTEGER, quote_category TEXT NOT NULL, quote TEXT NOT NULL, author TEXT NOT NULL, is_favorite INTEGER);";

      String query3 =
          "CREATE TABLE IF NOT EXISTS favorite_quotes(quote_id INTEGER, quote_category TEXT NOT NULL, quote TEXT NOT NULL, author TEXT NOT NULL, quote_image BLOB);";

      await db.execute(query1);
      await db.execute(query2);
      await db.execute(query3);
    });
  }

  Future insertCategory() async {
    await initDB();
    JsonController jsonController = JsonController();

    List<CategoryModel> categories = await jsonController.localJsonDecode();

    for (int i = 0; i < categories.length; i++) {
      String query1 =
          "INSERT INTO categories(category_id, category_name, category_icon, category_image) VALUES (? , ?, ?, ?);";
      List args1 = [
        categories[i].id,
        categories[i].categoryName,
        categories[i].icon,
        categories[i].image,
      ];

      int res = await db!.rawInsert(query1, args1);
    }

    for (int i = 0; i < categories.length; i++) {
      for (int j = 0; j < categories[i].quotes.length; j++) {
        String query2 =
            "INSERT INTO quotes(quote_id, quote_category, quote, author, is_favorite) VALUES (? , ? , ? , ?, ?);";

        List args2 = [
          categories[i].quotes[j].id,
          categories[i].quotes[j].category,
          categories[i].quotes[j].quote,
          categories[i].quotes[j].author,
          categories[i].quotes[j].isFavorite,
        ];

        int res = await db!.rawInsert(query2, args2);
      }
    }
  }

  Future updateFavoriteQuote(
      {required int isFavorite,
      required int quoteId,
      required String quoteCategory}) async {
    initDB();

    String query =
        "UPDATE quotes SET is_favorite = ? WHERE quote_id = ? AND quote_category = ?;";
    List args = [isFavorite, quoteId, quoteCategory];

    await db!.rawUpdate(query, args);
  }

  Future insertFavoriteQuotes({required FavoriteDataBaseModel data}) async {
    await initDB();
    await updateFavoriteQuote(
        isFavorite: 1,
        quoteId: data.quoteId,
        quoteCategory: data.quoteCategory);

    String query =
        "INSERT INTO favorite_quotes(quote_id, quote_category, quote, author, quote_image) VALUES (? , ? , ? , ?, ?);";

    List args = [
      data.quoteId,
      data.quoteCategory,
      data.quote,
      data.quoteAuthor,
      Uint8List.fromList(data.quoteImage.codeUnits),
    ];

    await db!.rawInsert(query, args);
  }

  Future<List<FavoriteDataBaseModel>> deleteFromFavoriteQuote(
      {required int quoteId, required String quoteCategory}) async {
    await initDB();
    await updateFavoriteQuote(
        isFavorite: 0, quoteId: quoteId, quoteCategory: quoteCategory);

    String query =
        "DELETE FROM favorite_quotes WHERE quote_id = ? AND quote_category = ?;";

    List args = [quoteId, quoteCategory];

    await db!.rawDelete(query, args);

    return await fetchFavoriteQuotes();
  }

  Future<List<FavoriteDataBaseModel>> fetchFavoriteQuotes() async {
    await initDB();

    String query = "SELECT * FROM favorite_quotes;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<FavoriteDataBaseModel> allFavorite =
        res.map((e) => FavoriteDataBaseModel.fromMap(data: e)).toList();
    return allFavorite;
  }

  Future<List<CategoryDatabaseModel>> fetchAllCategory() async {
    await initDB();

    DataBaseCheckController dataBaseCheckController = DataBaseCheckController();

    if (getStorage.read("isTableInserted") != true) {
      await insertCategory();
      dataBaseCheckController.dataInserted();
    }

    String query = "SELECT * FROM categories;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<CategoryDatabaseModel> allCategories =
        res.map((e) => CategoryDatabaseModel.formMap(data: e)).toList();

    return allCategories;
  }

  Future<List<CategoryDatabaseModel>> fetchSearchCategory(
      {required String data}) async {
    await initDB();

    String query =
        "SELECT * FROM categories WHERE category_name LIKE '%$data%';";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<CategoryDatabaseModel> allCategories =
        res.map((e) => CategoryDatabaseModel.formMap(data: e)).toList();

    return allCategories;
  }

  Future<List<QuotesDatabaseModel>> fetchAllQuotes(
      {required String categoryName}) async {
    await initDB();

    String query = "SELECT * FROM quotes WHERE quote_category = ?;";
    List args = [categoryName];

    List<Map<String, dynamic>> res = await db!.rawQuery(query, args);

    List<QuotesDatabaseModel> allQuotes =
        res.map((e) => QuotesDatabaseModel.formMap(data: e)).toList();

    return allQuotes;
  }

  Future<List<QuotesDatabaseModel>> fetchQuote(
      {required int quoteId, required String categoryName}) async {
    await initDB();

    String query =
        "SELECT * FROM quotes WHERE quote_id = ? AND quote_category = ?;";
    List args = [quoteId, categoryName];

    List<Map<String, dynamic>> res = await db!.rawQuery(query, args);

    List<QuotesDatabaseModel> quote =
        res.map((e) => QuotesDatabaseModel.formMap(data: e)).toList();

    return quote;
  }
}
