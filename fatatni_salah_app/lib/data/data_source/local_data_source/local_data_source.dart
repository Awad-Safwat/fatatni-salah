import 'package:fatatni_salah_app/core/utils/app_strings.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/one_day_data.model.dart';

import 'package:hive/hive.dart';

class LocalDataSource {
  // save the Data for the current and the next month
  void saveCurrentNextMonthLocal(
      List<OneDayDataModel> currentNextMonthData) async {
    var box = await Hive.openBox(AppStrings.currentNextMonthDataBox);
    box.put(AppStrings.currentNextMonthDataBox, currentNextMonthData);
  }

  // get the Data for the current and the next month
  Future<List<dynamic>> getCurrentNextMonthData() async {
    print('getting data locally');
    var box = await Hive.openBox(AppStrings.currentNextMonthDataBox);

    var data = await box.get(AppStrings.currentNextMonthDataBox);
    return data;
  }
}
