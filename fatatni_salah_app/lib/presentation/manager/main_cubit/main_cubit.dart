import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:fatatni_salah_app/core/error_handler/faluer.dart';
import 'package:fatatni_salah_app/core/services/notification/notification_init.dart';
import 'package:fatatni_salah_app/core/shared/functions.dart';
import 'package:fatatni_salah_app/core/utils/app_strings.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/one_day_data.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/prayer_model.dart';
import 'package:fatatni_salah_app/data/repos_impel/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'main_cubit_state.dart';

class MainCubitCubit extends Cubit<MainCubitState> {
  MainCubitCubit({required this.dataRepository}) : super(MainCubitInitial());

  final DataRepository dataRepository;

  List<OneDayDataModel>? dataForTheDay;

  List<Prayer>? missedPrayers;

  void getPrayersData(BuildContext context) async {
    emit(MainCubitLoading());

    Notifications.requestToAllowNotifications().then((_) async {
      var respons = await dataRepository.getTheDataForTodayAndTomorrow();
      missedPrayers = await getMissedPrayers();
      respons.fold((fail) {
        emit(MainCubitFailer(errorMasseg: fail.massege));
      }, (data) {
        dataForTheDay = data;
        extractPrayeres(data);
        emit(MainCubitSucsses());
      });
    });
  }

  Future<List<Prayer>> getMissedPrayers() async {
    List<Prayer> prayers = [];
    var box = await Hive.openBox(AppStrings.missedPrayersBox);
    var data = box.values;
    for (var element in data) {
      prayers.add(Prayer(time: element.time, title: element.title));
    }
    return prayers;
  }
}
