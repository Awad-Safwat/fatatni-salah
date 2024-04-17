import 'package:fatatni_salah_app/data/models/one_day_data_model/designation.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/month.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/weekday.model.dart';
import 'package:fatatni_salah_app/hive_helper/fields/hijri_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';

part 'hijri.model.g.dart';

@HiveType(typeId: HiveTypes.hijri, adapterName: HiveAdapters.hijri)
class Hijri extends HiveObject {
  @HiveField(HijriFields.date)
  String? date;
  @HiveField(HijriFields.format)
  String? format;
  @HiveField(HijriFields.day)
  String? day;
  @HiveField(HijriFields.weekday)
  Weekday? weekday;
  @HiveField(HijriFields.month)
  Month? month;
  @HiveField(HijriFields.year)
  String? year;
  @HiveField(HijriFields.designation)
  Designation? designation;
  @HiveField(HijriFields.holidays)
  List<dynamic>? holidays;

  Hijri({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
    this.holidays,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
        date: json['date'] as String?,
        format: json['format'] as String?,
        day: json['day'] as String?,
        weekday: json['weekday'] == null
            ? null
            : Weekday.fromJson(json['weekday'] as Map<String, dynamic>),
        month: json['month'] == null
            ? null
            : Month.fromJson(json['month'] as Map<String, dynamic>),
        year: json['year'] as String?,
        designation: json['designation'] == null
            ? null
            : Designation.fromJson(json['designation'] as Map<String, dynamic>),
        holidays: json['holidays'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'format': format,
        'day': day,
        'weekday': weekday?.toJson(),
        'month': month?.toJson(),
        'year': year,
        'designation': designation?.toJson(),
        'holidays': holidays,
      };
}
