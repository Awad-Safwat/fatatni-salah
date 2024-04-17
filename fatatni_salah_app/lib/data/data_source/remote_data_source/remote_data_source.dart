import 'package:fatatni_salah_app/core/services/network/apis_services.dart';
import 'package:fatatni_salah_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/one_day_data.model.dart';

class RemoteDataSource {
  final ApiService apiService;

  final LocalDataSource localDataSource;

  RemoteDataSource({required this.apiService, required this.localDataSource});

  Future<List<OneDayDataModel>> getCurrentNextMonthData(
      {required double lat, required double long}) async {
    List<OneDayDataModel> allDataForCurrentNextMonth = [];
    print('gitting data online');
    Map<String, dynamic>? nextMonth, currentMonth;
    await apiService.get(params: {
      "latitude": lat,
      "longitude": long,
      "year": DateTime.now().year,
      'school': 0,
    }).then((currentMonthResponse) async {
      currentMonth = currentMonthResponse;
      nextMonth = await apiService.get(params: {
        "latitude": lat,
        "longitude": long,
        "year": DateTime.now().year,
        "month": DateTime.now().month + 1 == 13 ? 1 : DateTime.now().month + 1,
        'school': 0,
      });
    });

    for (Map<String, dynamic> dayData in currentMonth!['data']) {
      allDataForCurrentNextMonth.add(OneDayDataModel.fromJson(dayData));
    }
    for (Map<String, dynamic> dayData in nextMonth!['data']) {
      allDataForCurrentNextMonth.add(OneDayDataModel.fromJson(dayData));
    }
    localDataSource.saveCurrentNextMonthLocal(allDataForCurrentNextMonth);

    return allDataForCurrentNextMonth;
  }
}
