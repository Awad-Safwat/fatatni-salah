import 'package:fatatni_salah_app/data/models/one_day_data_model/designation.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/month.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/weekday.model.dart';
import 'package:fatatni_salah_app/hive_helper/fields/gregorian_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive_flutter/adapters.dart';

part 'gregorian.model.g.dart';

@HiveType(typeId: HiveTypes.gregorian, adapterName: HiveAdapters.gregorian)
class Gregorian extends HiveObject {
  @HiveField(GregorianFields.date)
  String? date;
  @HiveField(GregorianFields.format)
  String? format;
  @HiveField(GregorianFields.day)
  String? day;
  @HiveField(GregorianFields.weekday)
  Weekday? weekday;
  @HiveField(GregorianFields.month)
  Month? month;
  @HiveField(GregorianFields.year)
  String? year;
  @HiveField(GregorianFields.designation)
  Designation? designation;

  Gregorian({
    this.date,
    this.format,
    this.day,
    this.weekday,
    this.month,
    this.year,
    this.designation,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
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
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'format': format,
        'day': day,
        'weekday': weekday?.toJson(),
        'month': month?.toJson(),
        'year': year,
        'designation': designation?.toJson(),
      };
}
