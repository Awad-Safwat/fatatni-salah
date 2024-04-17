import 'package:hive/hive.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/fields/prayer_fields.dart';

part 'prayer_model.g.dart';

@HiveType(typeId: HiveTypes.prayer, adapterName: HiveAdapters.prayer)
class Prayer extends HiveObject {
  @HiveField(PrayerFields.time)
  DateTime time;
  @HiveField(PrayerFields.title)
  String title;
  Prayer({
    required this.time,
    required this.title,
  });
}
