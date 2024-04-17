import 'package:fatatni_salah_app/hive_helper/fields/location_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';

part 'location.model.g.dart';

@HiveType(typeId: HiveTypes.location, adapterName: HiveAdapters.location)
class Location extends HiveObject {
  @HiveField(LocationFields.latitude)
  double? latitude;
  @HiveField(LocationFields.longitude)
  double? longitude;

  Location({this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: (json['latitude']),
        longitude: (json['longitude']),
      );

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}
