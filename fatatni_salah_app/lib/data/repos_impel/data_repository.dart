import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dartz/dartz.dart';
import 'package:fatatni_salah_app/core/error_handler/faluer.dart';
import 'package:fatatni_salah_app/core/shared/functions.dart';
import 'package:fatatni_salah_app/core/utils/app_colors.dart';
import 'package:fatatni_salah_app/core/utils/app_strings.dart';
import 'package:fatatni_salah_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:fatatni_salah_app/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/one_day_data.model.dart';
import 'package:fatatni_salah_app/data/models/notification_prayer_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class DataRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  DataRepository(
      {required this.localDataSource, required this.remoteDataSource});

  Future<Either<Falure, List<OneDayDataModel>>>
      getTheDataForTodayAndTomorrow() async {
    List<OneDayDataModel> dataForTodayAndTomorrow = [];
    var metaDataBox = await Hive.openBox('metaData');
    var currentNextMonthDataBox =
        await Hive.openBox(AppStrings.currentNextMonthDataBox);
    if (metaDataBox.get('country') == null) {
      await saveLocationDataLocal();
      //.then((_) => Restart.restartApp())
    }
    metaDataBox = await Hive.openBox('metaData');
    final DateTime savedDate = metaDataBox.get('date');
    late List<dynamic> allDataForCurrenNextMonth;

    try {
      if (savedDate.month == DateTime.now().month &&
          currentNextMonthDataBox.isNotEmpty) {
        allDataForCurrenNextMonth =
            await localDataSource.getCurrentNextMonthData();
        scheduleNotifications(allDataForCurrenNextMonth);
      } else {
        allDataForCurrenNextMonth =
            await remoteDataSource.getCurrentNextMonthData(
          lat: metaDataBox.get('lat'),
          long: metaDataBox.get('lon'),
        );

        scheduleNotifications(allDataForCurrenNextMonth);
      }

      for (OneDayDataModel oneDay in allDataForCurrenNextMonth) {
        if (DateUtils.isSameDay(
              DateFormat("dd-MM-yyyy").parse(oneDay.date!.gregorian!.date!),
              DateTime.now(),
            ) ||
            DateUtils.isSameDay(
              DateFormat("dd-MM-yyyy").parse(oneDay.date!.gregorian!.date!),
              DateTime.now().copyWith(day: DateTime.now().day + 1),
            )) {
          dataForTodayAndTomorrow.add(oneDay);
        }
      }

      return right(dataForTodayAndTomorrow);
    } catch (error) {
      return left(ServerFalure(massege: error.toString()));
    }
  }

  // Schedule All Notifications for five dayes
  scheduleNotifications(dynamic allCurrentNextMonthData) async {
    await AwesomeNotifications().cancelAllSchedules();
    int dayesCounter = 0;
    int notificationId = 0;
    for (OneDayDataModel oneDay in allCurrentNextMonthData) {
      if (DateUtils.isSameDay(
            DateFormat("dd-MM-yyyy").parse(oneDay.date!.gregorian!.date!),
            DateTime.now(),
          ) ||
          (dayesCounter > 0 && dayesCounter < 5)) {
        dayesCounter++;
        List<PrayeNotificationModel> dayPrayers = [];
        dayPrayers.add(
          PrayeNotificationModel(
              notificationTime: convertPrayerTimeToDateTime(
                  date: oneDay.date!.gregorian!, time: oneDay.timings!.fajr!),
              notificationTitle: "Al Fajr",
              notificationBody:
                  "وَأَقِمِ الصَّلَاةَ إِنَّ الصَّلَاةَ تَنْهَى عَنِ الْفَحْشَاءِ وَالْمُنكَرِ"),
        );

        dayPrayers.add(
          PrayeNotificationModel(
              notificationTime: convertPrayerTimeToDateTime(
                  date: oneDay.date!.gregorian!, time: oneDay.timings!.dhuhr!),
              notificationTitle: oneDay.date!.gregorian!.weekday?.en == 'Friday'
                  ? "Al Jamaa'ah"
                  : "Al Duhr",
              notificationBody:
                  "وَأَقِمِ الصَّلَاةَ إِنَّ الصَّلَاةَ تَنْهَى عَنِ الْفَحْشَاءِ وَالْمُنكَرِ"),
        );

        dayPrayers.add(
          PrayeNotificationModel(
              notificationTime: convertPrayerTimeToDateTime(
                  date: oneDay.date!.gregorian!, time: oneDay.timings!.asr!),
              notificationTitle: "Al Asr",
              notificationBody:
                  "وَأَقِمِ الصَّلَاةَ إِنَّ الصَّلَاةَ تَنْهَى عَنِ الْفَحْشَاءِ وَالْمُنكَرِ"),
        );

        dayPrayers.add(
          PrayeNotificationModel(
            notificationTime: convertPrayerTimeToDateTime(
                date: oneDay.date!.gregorian!, time: oneDay.timings!.maghrib!),
            notificationTitle: "Al Maghrib",
            notificationBody:
                "وَأَقِمِ الصَّلَاةَ إِنَّ الصَّلَاةَ تَنْهَى عَنِ الْفَحْشَاءِ وَالْمُنكَرِ",
          ),
        );

        dayPrayers.add(
          PrayeNotificationModel(
            notificationTime: convertPrayerTimeToDateTime(
                date: oneDay.date!.gregorian!, time: oneDay.timings!.isha!),
            notificationTitle: "Al Isha",
            notificationBody:
                "وَأَقِمِ الصَّلَاةَ إِنَّ الصَّلَاةَ تَنْهَى عَنِ الْفَحْشَاءِ وَالْمُنكَرِ",
          ),
        );

        for (int prayer = 0; prayer < 5; prayer++) {
          notificationId++;
          await AwesomeNotifications()
              .createNotification(
            content: NotificationContent(
              id: notificationId,
              channelKey: AppStrings.notificationAthanChanelKey,
              title: "It's Time for ${dayPrayers[prayer].notificationTitle}",
              body: dayPrayers[prayer].notificationBody,
              wakeUpScreen: true,
              category: NotificationCategory.Alarm,
              timeoutAfter: const Duration(minutes: 6),
            ),
            schedule: NotificationCalendar.fromDate(
                date: dayPrayers[prayer].notificationTime,
                allowWhileIdle: true,
                preciseAlarm: true),
          )
              .then((_) async {
            print('Notification $notificationId scheduled');
            await AwesomeNotifications().createNotification(
              content: NotificationContent(
                  id: notificationId + 100,
                  channelKey: AppStrings.notificationQuestionChannelKey,
                  title: "Did you did ${dayPrayers[prayer].notificationTitle}",
                  body: dayPrayers[prayer].notificationBody,
                  wakeUpScreen: true,
                  payload: {
                    'prayerTitle': dayPrayers[prayer].notificationTitle,
                    'prayerDate': dayPrayers[prayer].notificationTime.toString()
                  },
                  autoDismissible: false,
                  notificationLayout: NotificationLayout.Messaging),
              actionButtons: [
                NotificationActionButton(
                  key: AppStrings.notificationDoneButtonKey,
                  label: AppStrings.notificationDoneButtonLable,
                  actionType: ActionType.SilentAction,
                  color: AppColors.green,
                ),
                NotificationActionButton(
                    key: AppStrings.notificationnotYetButtonKey,
                    label: AppStrings.notificationnotYetButtonLable,
                    actionType: ActionType.SilentAction,
                    color: AppColors.red),
              ],
              schedule: NotificationCalendar.fromDate(
                  date: dayPrayers[prayer]
                      .notificationTime
                      .add(const Duration(minutes: 45)),
                  allowWhileIdle: true,
                  preciseAlarm: true),
            );
            print('Notification ${notificationId + 100} scheduled');
          });
        }
      }
    }
  }
}
