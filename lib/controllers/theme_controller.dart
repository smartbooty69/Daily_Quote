import 'package:flutter/material.dart';
import 'package:quotes_app/models/theme_model.dart';
import 'package:quotes_app/utils/globals.dart';

class ThemeController extends ChangeNotifier {
  ThemeModel themeModel;

  ThemeController({required this.themeModel});

  changeTheme({required bool val}) async {
    themeModel.isDark = val;

    getStorage.write("isDark", themeModel.isDark);
    notifyListeners();
  }
}
