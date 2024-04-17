import 'package:hive/hive.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/fields/designation_fields.dart';

part 'designation.model.g.dart';

@HiveType(typeId: HiveTypes.designation, adapterName: HiveAdapters.designation)
class Designation extends HiveObject {
  @HiveField(DesignationFields.abbreviated)
  String? abbreviated;
  @HiveField(DesignationFields.expanded)
  String? expanded;

  Designation({this.abbreviated, this.expanded});

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        abbreviated: json['abbreviated'] as String?,
        expanded: json['expanded'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'abbreviated': abbreviated,
        'expanded': expanded,
      };
}
