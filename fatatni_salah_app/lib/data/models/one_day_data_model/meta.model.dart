import 'package:fatatni_salah_app/data/models/one_day_data_model/method.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/offset.model.dart';
import 'package:fatatni_salah_app/hive_helper/fields/meta_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';

part 'meta.model.g.dart';

@HiveType(typeId: HiveTypes.meta, adapterName: HiveAdapters.meta)
class Meta extends HiveObject {
  @HiveField(MetaFields.latitude)
  double? latitude;
  @HiveField(MetaFields.longitude)
  double? longitude;
  @HiveField(MetaFields.timezone)
  String? timezone;
  @HiveField(MetaFields.method)
  Method? method;
  @HiveField(MetaFields.latitudeAdjustmentMethod)
  String? latitudeAdjustmentMethod;
  @HiveField(MetaFields.midnightMode)
  String? midnightMode;
  @HiveField(MetaFields.school)
  String? school;
  @HiveField(MetaFields.offset)
  Offset? offset;

  Meta({
    this.latitude,
    this.longitude,
    this.timezone,
    this.method,
    this.latitudeAdjustmentMethod,
    this.midnightMode,
    this.school,
    this.offset,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        latitude: (json['latitude']),
        longitude: (json['longitude']),
        timezone: json['timezone'] as String?,
        method: json['method'] == null
            ? null
            : Method.fromJson(json['method'] as Map<String, dynamic>),
        latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'] as String?,
        midnightMode: json['midnightMode'] as String?,
        school: json['school'] as String?,
        offset: json['offset'] == null
            ? null
            : Offset.fromJson(json['offset'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'timezone': timezone,
        'method': method?.toJson(),
        'latitudeAdjustmentMethod': latitudeAdjustmentMethod,
        'midnightMode': midnightMode,
        'school': school,
        'offset': offset?.toJson(),
      };
}
