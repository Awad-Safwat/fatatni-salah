import 'package:fatatni_salah_app/hive_helper/fields/month_fields.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';

part 'month.model.g.dart';

@HiveType(typeId: HiveTypes.month, adapterName: HiveAdapters.month)
class Month extends HiveObject {
  @HiveField(MonthFields.number)
  int? number;
  @HiveField(MonthFields.en)
  String? en;
  @HiveField(MonthFields.ar)
  String? ar;

  Month({this.number, this.en, this.ar});

  factory Month.fromJson(Map<String, dynamic> json) => Month(
        number: json['number'] as int?,
        en: json['en'] as String?,
        ar: json['ar'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'en': en,
        'ar': ar,
      };
}
