import 'package:dartz/dartz.dart';
import 'package:fatatni_salah_app/core/error_handler/faluer.dart';
import 'package:fatatni_salah_app/core/shared/variables.dart';
import 'package:fatatni_salah_app/core/utils/app_strings.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/gregorian.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/one_day_data.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/prayer_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

String extractTimeWithoutTimezone(String text) {
  // Regular expression to match the time format (HH:MM)
  RegExp regExp = RegExp(r'^(\d{2}:\d{2})');

  // Extract the time from the text
  Match? match = regExp.firstMatch(text);
  if (match != null) {
    return match.group(0)!; // Return the matched time
  }
  return ""; // Return an empty string if no match found
}

DateTime convertPrayerTimeToDateTime(
    {required String time, required Gregorian date}) {
  DateTime prayerTime = DateFormat.Hm().parse(
    extractTimeWithoutTimezone(time),
  );
  DateTime dateFormated = DateFormat("dd-MM-yyyy").parse(date.date!);
  prayerTime = prayerTime.copyWith(
    year: dateFormated.year,
    month: date.month!.number,
    day: dateFormated.day,
  );

  return prayerTime;
}

// extract prayers from holl data of the day
void extractPrayeres(List<OneDayDataModel> dayData) {
  prayersOfTheDay.add(Prayer(
    time: convertPrayerTimeToDateTime(
        time: dayData[0].timings!.fajr!, date: dayData[0].date!.gregorian!),
    title: 'Fajr',
  ));
  prayersOfTheDay.add(Prayer(
    time: convertPrayerTimeToDateTime(
        time: dayData[0].timings!.sunrise!, date: dayData[0].date!.gregorian!),
    title: 'Sunrise',
  ));
  prayersOfTheDay.add(Prayer(
    time: convertPrayerTimeToDateTime(
        time: dayData[0].timings!.dhuhr!, date: dayData[0].date!.gregorian!),
    title: dayData[0].date!.gregorian!.weekday?.en == 'Friday'
        ? 'Jamaa\'ah'
        : 'Duhr',
  ));
  prayersOfTheDay.add(Prayer(
    time: convertPrayerTimeToDateTime(
        time: dayData[0].timings!.asr!, date: dayData[0].date!.gregorian!),
    title: 'Asr',
  ));
  prayersOfTheDay.add(Prayer(
    time: convertPrayerTimeToDateTime(
        time: dayData[0].timings!.maghrib!, date: dayData[0].date!.gregorian!),
    title: 'Maghrib',
  ));
  prayersOfTheDay.add(Prayer(
    time: convertPrayerTimeToDateTime(
        time: dayData[0].timings!.isha!, date: dayData[0].date!.gregorian!),
    title: 'Isha',
  ));
  //get the time of the fajr prayer for the next day to can callculated romaining time after prayer Isha of today
  prayersOfTheDay.add(Prayer(
    time: convertPrayerTimeToDateTime(
        time: dayData[1].timings!.fajr!, date: dayData[1].date!.gregorian!),
    title: 'Fajr',
  ));
}

Prayer? getNextPrayer() {
  DateTime now = DateTime.now();
  for (Prayer prayer in prayersOfTheDay) {
    if (prayer.time.isAfter(now)) {
      return prayer;
    } else if (prayer.time.isAtSameMomentAs(now)) {
      // prayer.status = 'now';
    } else {
      // prayer.status = 'final';
    }
  }
  return null;
}

Future<Either<Falure, Position>> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    return left(ServerFalure(
      massege: 'Location services are disabled.',
    ));
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return left(ServerFalure(massege: 'Location permissions are denied'));
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return left(ServerFalure(
        massege:
            'Location permissions are permanently denied, we cannot request permissions.'));
  }
  // continue accessing the position of the device.
  return right(await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high));
}

Future<void> saveLocationDataLocal() async {
  var response = await getCurrentLocation();
  response.fold((error) => print(error.massege), (locationData) async {
    var box = await Hive.openBox('metaData');
    box.put('lat', locationData.latitude);
    box.put('lon', locationData.longitude);
    box.put('date', DateTime.now());
    List<Placemark> placemarks = await placemarkFromCoordinates(
      locationData.latitude,
      locationData.longitude,
    );
    print(placemarks);
    print(placemarks[1].toString());

    box.put('country', placemarks[0].country);
    box.put('city', placemarks[0].locality);
    print(placemarks[0].locality);
  });
}

Future<void> requestAServicePermission(
  BuildContext context, {
  required Permission permissionNeded,
  required String requestTitle,
  required String requestBody,
}) async {
  var status = await permissionNeded.status;
  PermissionStatus? result;
  if (!status.isGranted) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(requestTitle),
        content: Text(requestBody),
        actions: [
          TextButton(
            onPressed: () async {
              result = await permissionNeded.request();
              if (result!.isGranted) {
                // Permission granted, show success message or proceed with notifications
                Navigator.pop(context);
                return;
              }
            },
            child: const Text('Allow'),
          ),
        ],
      ),
    );
  } else {
    // Permission already granted, show success message or proceed with notifications
    return;
  }
}

void saveNewMissedPrayer(Map<String, String?> notificationData) async {
  Prayer missedPrayer = Prayer(
      time: DateTime.parse(notificationData['prayerDate']!),
      title: notificationData['prayerTitle']!);
  var box = await Hive.openBox(AppStrings.missedPrayersBox);
  box.put(
      '${notificationData['prayerDate'].toString()}${notificationData['prayerTitle']}',
      missedPrayer);
  print(
      "${notificationData['prayerDate'].toString()}${notificationData['prayerTitle']} is added to missed prayers");
}
