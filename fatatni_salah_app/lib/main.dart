import 'package:fatatni_salah_app/core/services/notification/notification_init.dart';
import 'package:fatatni_salah_app/fatatni_app.dart';
import 'package:fatatni_salah_app/hive_helper/register_adapters.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  registerAdapters();
  Notifications.initNotifications();
  Notifications.setListeners();

  runApp(const FatatniSalah());
}
