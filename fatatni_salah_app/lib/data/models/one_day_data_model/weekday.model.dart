import 'package:fatatni_salah_app/hive_helper/fields/weekday_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';
part 'weekday.model.g.dart';

@HiveType(typeId: HiveTypes.weekday, adapterName: HiveAdapters.weekday)
class Weekday extends HiveObject {
  @HiveField(WeekdayFields.en)
  String? en;
  @HiveField(WeekdayFields.ar)
  String? ar;

  Weekday({this.en, this.ar});

  factory Weekday.fromJson(Map<String, dynamic> json) => Weekday(
        en: json['en'] as String?,
        ar: json['ar'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ar': ar,
      };
}
