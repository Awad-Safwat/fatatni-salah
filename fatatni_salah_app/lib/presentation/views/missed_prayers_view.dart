import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'package:fatatni_salah_app/core/services/network/apis_services.dart';
import 'package:fatatni_salah_app/core/shared/functions.dart';
import 'package:fatatni_salah_app/core/utils/app_strings.dart';
import 'package:fatatni_salah_app/data/data_source/local_data_source/local_data_source.dart';
import 'package:fatatni_salah_app/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:fatatni_salah_app/data/repos_impel/data_repository.dart';
import 'package:fatatni_salah_app/presentation/manager/main_cubit/main_cubit.dart';
import 'package:fatatni_salah_app/presentation/widgets/count_down_card_widget.dart';
import 'package:fatatni_salah_app/presentation/widgets/missed_pray_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MissedPrayersView extends StatelessWidget {
  const MissedPrayersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubitCubit(
        dataRepository: DataRepository(
          localDataSource: LocalDataSource(),
          remoteDataSource: RemoteDataSource(
              apiService: ApiService(dio: Dio()),
              localDataSource: LocalDataSource()),
        ),
      )..getPrayersData(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Missed Prayes'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<MainCubitCubit, MainCubitState>(
              builder: (context, state) {
                if (state is MainCubitFailer) {
                  return Text(state.errorMasseg);
                } else if (state is MainCubitSucsses) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CountDownCardWidget(),
                      Text(DateFormat('hh:mm a').format(getNextPrayer()!.time)),
                      BlocProvider.of<MainCubitCubit>(context)
                              .missedPrayers!
                              .isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount:
                                    BlocProvider.of<MainCubitCubit>(context)
                                        .missedPrayers!
                                        .length,
                                itemBuilder: (context, index) =>
                                    MissedPrayWidget(
                                  prayerTime:
                                      BlocProvider.of<MainCubitCubit>(context)
                                          .missedPrayers![index]
                                          .time,
                                  prayerName:
                                      BlocProvider.of<MainCubitCubit>(context)
                                          .missedPrayers![index]
                                          .title,
                                ),
                              ),
                            )
                          : const Text('There is no missed prayers'),
                      MaterialButton(
                        onPressed: () async {
                          // List<NotificationModel> notifications =
                          //     await AwesomeNotifications().cancelAllSchedules();
                          // print(notifications[6].schedule.toString());
                          // for (NotificationModel notification in notifications) {

                          // }

                          await AwesomeNotifications().createNotification(
                            content: NotificationContent(
                              id: 700,
                              channelKey: AppStrings.notificationAthanChanelKey,
                              title: "حان الآن موعد أذان العشاء",
                              body:
                                  "وَأَقِمِ الصَّلَاةَ إِنَّ الصَّلَاةَ تَنْهَى عَنِ الْفَحْشَاءِ وَالْمُنكَرِ",
                              wakeUpScreen: true,
                              category: NotificationCategory.Alarm,
                            ),
                          );
                          await AwesomeNotifications().createNotification(
                            content: NotificationContent(
                                id: 701,
                                channelKey:
                                    AppStrings.notificationQuestionChannelKey,
                                title: "هل صليت العشاء ؟",
                                body:
                                    "وَأَقِمِ الصَّلَاةَ إِنَّ الصَّلَاةَ تَنْهَى عَنِ الْفَحْشَاءِ وَالْمُنكَرِ",
                                wakeUpScreen: true,
                                payload: {
                                  'prayerTitle': 'AL Isha',
                                  'prayerDate': DateTime.now().toString()
                                },
                                autoDismissible: false,
                                notificationLayout:
                                    NotificationLayout.Messaging),
                            actionButtons: [
                              NotificationActionButton(
                                key: AppStrings.notificationDoneButtonKey,
                                label: AppStrings.notificationDoneButtonLable,
                                actionType: ActionType.SilentAction,
                                color: Colors.blue,
                                showInCompactView: true,
                              ),
                              NotificationActionButton(
                                key: AppStrings.notificationnotYetButtonKey,
                                label: AppStrings.notificationnotYetButtonLable,
                                actionType: ActionType.SilentAction,
                                color: Colors.red,
                                showInCompactView: true,
                              ),
                            ],
                            schedule: NotificationCalendar(
                                second: 30,
                                allowWhileIdle: true,
                                preciseAlarm: true),
                          );
                        },
                        child: const Text('Add A Prayer'),
                      )
                    ],
                  );
                } else {
                  return const CircularProgressIndicator.adaptive();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
