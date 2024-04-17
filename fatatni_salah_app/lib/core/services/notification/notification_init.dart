import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fatatni_salah_app/core/shared/functions.dart';
import 'package:fatatni_salah_app/core/utils/app_strings.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/prayer_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Notifications {
  static void initNotifications() {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
            channelGroupKey: AppStrings.notificationsChanelsGroub,
            channelKey: AppStrings.notificationAthanChanelKey,
            channelName: AppStrings.notificationAthanChanelName,
            channelDescription: 'Notification channel for Prayer Athan',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white,
            soundSource: 'resource://raw/athan',
            criticalAlerts: true,
            importance: NotificationImportance.Max,
            enableVibration: false,
            onlyAlertOnce: true,
            defaultRingtoneType: DefaultRingtoneType.Alarm,
          ),
          NotificationChannel(
            channelGroupKey: AppStrings.notificationsChanelsGroub,
            channelKey: AppStrings.notificationQuestionChannelKey,
            channelName: AppStrings.notificationQuestionChannelName,
            channelDescription:
                'Notification channel for Asking the user wether he prayed or missed',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white,
            // soundSource: 'resource://raw/athan',
            criticalAlerts: true,

            importance: NotificationImportance.Max,
          ),
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'fatatni_salah_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
  }

  static void setListeners() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
  }

  static Future<void> requestToAllowNotifications() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here

    // Navigate into pages, avoiding to open the notification details page over another details page already opened
    // MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil('/notification-page',
    //         (route) => (route.settings.name != '/notification-page') || route.isFirst,
    //     arguments: receivedAction);
    if (receivedAction.buttonKeyPressed ==
            AppStrings.notificationnotYetButtonKey &&
        receivedAction.channelKey ==
            AppStrings.notificationQuestionChannelKey) {
      saveNewMissedPrayer(receivedAction.payload!);
    } else if (receivedAction.buttonKeyPressed ==
            AppStrings.notificationDoneButtonKey &&
        receivedAction.channelKey ==
            AppStrings.notificationQuestionChannelKey) {}
  }
}
