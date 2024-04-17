import 'package:fatatni_salah_app/hive_helper/fields/offset_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';

part 'offset.model.g.dart';

@HiveType(typeId: HiveTypes.offset, adapterName: HiveAdapters.offset)
class Offset extends HiveObject {
  @HiveField(OffsetFields.imsak)
  int? imsak;
  @HiveField(OffsetFields.fajr)
  int? fajr;
  @HiveField(OffsetFields.sunrise)
  int? sunrise;
  @HiveField(OffsetFields.dhuhr)
  int? dhuhr;
  @HiveField(OffsetFields.asr)
  int? asr;
  @HiveField(OffsetFields.maghrib)
  int? maghrib;
  @HiveField(OffsetFields.sunset)
  int? sunset;
  @HiveField(OffsetFields.isha)
  int? isha;
  @HiveField(OffsetFields.midnight)
  int? midnight;

  Offset({
    this.imsak,
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.maghrib,
    this.sunset,
    this.isha,
    this.midnight,
  });

  factory Offset.fromJson(Map<String, dynamic> json) => Offset(
        imsak: json['Imsak'] as int?,
        fajr: json['Fajr'] as int?,
        sunrise: json['Sunrise'] as int?,
        dhuhr: json['Dhuhr'] as int?,
        asr: json['Asr'] as int?,
        maghrib: json['Maghrib'] as int?,
        sunset: json['Sunset'] as int?,
        isha: json['Isha'] as int?,
        midnight: json['Midnight'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'Imsak': imsak,
        'Fajr': fajr,
        'Sunrise': sunrise,
        'Dhuhr': dhuhr,
        'Asr': asr,
        'Maghrib': maghrib,
        'Sunset': sunset,
        'Isha': isha,
        'Midnight': midnight,
      };
}
