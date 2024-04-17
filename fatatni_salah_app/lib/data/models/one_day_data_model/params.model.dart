import 'package:fatatni_salah_app/hive_helper/fields/params_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';

part 'params.model.g.dart';

@HiveType(typeId: HiveTypes.params, adapterName: HiveAdapters.params)
class Params extends HiveObject {
  @HiveField(ParamsFields.fajr)
  int? fajr;
  @HiveField(ParamsFields.isha)
  dynamic isha;

  Params({this.fajr, this.isha});

  factory Params.fromJson(Map<String, dynamic> json) => Params(
        fajr: (json['Fajr']),
        isha: (json['Isha']),
      );

  Map<String, dynamic> toJson() => {
        'Fajr': fajr,
        'Isha': isha,
      };
}
