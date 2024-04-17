import 'package:fatatni_salah_app/data/models/one_day_data_model/location.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/params.model.dart';
import 'package:fatatni_salah_app/hive_helper/fields/method_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';
part 'method.model.g.dart';

@HiveType(typeId: HiveTypes.method, adapterName: HiveAdapters.method)
class Method extends HiveObject {
  @HiveField(MethodFields.id)
  int? id;
  @HiveField(MethodFields.name)
  String? name;
  @HiveField(MethodFields.params)
  Params? params;
  @HiveField(MethodFields.location)
  Location? location;

  Method({this.id, this.name, this.params, this.location});

  factory Method.fromJson(Map<String, dynamic> json) => Method(
        id: json['id'] as int?,
        name: json['name'] as String?,
        params: json['params'] == null
            ? null
            : Params.fromJson(json['params'] as Map<String, dynamic>),
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'params': params?.toJson(),
        'location': location?.toJson(),
      };
}
