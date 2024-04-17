import 'package:fatatni_salah_app/data/models/one_day_data_model/gregorian.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/hijri.model.dart';
import 'package:hive/hive.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/fields/date_fields.dart';

part 'date.model.g.dart';

@HiveType(typeId: HiveTypes.date, adapterName: HiveAdapters.date)
class Date extends HiveObject {
  @HiveField(DateFields.readable)
  String? readable;
  @HiveField(DateFields.timestamp)
  String? timestamp;
  @HiveField(DateFields.gregorian)
  Gregorian? gregorian;
  @HiveField(DateFields.hijri)
  Hijri? hijri;

  Date({this.readable, this.timestamp, this.gregorian, this.hijri});

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        readable: json['readable'] as String?,
        timestamp: json['timestamp'] as String?,
        gregorian: json['gregorian'] == null
            ? null
            : Gregorian.fromJson(json['gregorian'] as Map<String, dynamic>),
        hijri: json['hijri'] == null
            ? null
            : Hijri.fromJson(json['hijri'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'readable': readable,
        'timestamp': timestamp,
        'gregorian': gregorian?.toJson(),
        'hijri': hijri?.toJson(),
      };
}
