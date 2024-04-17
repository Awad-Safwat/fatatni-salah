import 'package:fatatni_salah_app/hive_helper/fields/timings_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';
part 'timings.model.g.dart';

@HiveType(typeId: HiveTypes.timings, adapterName: HiveAdapters.timings)
class Timings extends HiveObject {
  @HiveField(TimingsFields.fajr)
  String? fajr;
  @HiveField(TimingsFields.sunrise)
  String? sunrise;
  @HiveField(TimingsFields.dhuhr)
  String? dhuhr;
  @HiveField(TimingsFields.asr)
  String? asr;
  @HiveField(TimingsFields.sunset)
  String? sunset;
  @HiveField(TimingsFields.maghrib)
  String? maghrib;
  @HiveField(TimingsFields.isha)
  String? isha;
  @HiveField(TimingsFields.imsak)
  String? imsak;
  @HiveField(TimingsFields.midnight)
  String? midnight;
  @HiveField(TimingsFields.firstthird)
  String? firstthird;
  @HiveField(TimingsFields.lastthird)
  String? lastthird;

  Timings({
    this.fajr,
    this.sunrise,
    this.dhuhr,
    this.asr,
    this.sunset,
    this.maghrib,
    this.isha,
    this.imsak,
    this.midnight,
    this.firstthird,
    this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) => Timings(
        fajr: json['Fajr'] as String?,
        sunrise: json['Sunrise'] as String?,
        dhuhr: json['Dhuhr'] as String?,
        asr: json['Asr'] as String?,
        sunset: json['Sunset'] as String?,
        maghrib: json['Maghrib'] as String?,
        isha: json['Isha'] as String?,
        imsak: json['Imsak'] as String?,
        midnight: json['Midnight'] as String?,
        firstthird: json['Firstthird'] as String?,
        lastthird: json['Lastthird'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Fajr': fajr,
        'Sunrise': sunrise,
        'Dhuhr': dhuhr,
        'Asr': asr,
        'Sunset': sunset,
        'Maghrib': maghrib,
        'Isha': isha,
        'Imsak': imsak,
        'Midnight': midnight,
        'Firstthird': firstthird,
        'Lastthird': lastthird,
      };
}
