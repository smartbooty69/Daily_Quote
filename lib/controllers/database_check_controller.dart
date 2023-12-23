import 'package:get/get.dart';
import 'package:quotes_app/models/database_check_model.dart';
import 'package:quotes_app/utils/globals.dart';

class DataBaseCheckController extends GetxController {
  DataBaseCheckModel dataBaseCheckModel =
      DataBaseCheckModel(isTableInserted: false);

  dataInserted() {
    dataBaseCheckModel.isTableInserted = true;

    getStorage.write("isTableInserted", dataBaseCheckModel.isTableInserted);
    update();
  }
}
