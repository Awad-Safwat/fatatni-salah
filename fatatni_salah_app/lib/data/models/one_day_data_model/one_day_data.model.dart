import 'package:fatatni_salah_app/data/models/one_day_data_model/date.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/meta.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/timings.model.dart';
import 'package:hive/hive.dart';
import 'package:fatatni_salah_app/hive_helper/hive_types.dart';
import 'package:fatatni_salah_app/hive_helper/hive_adapters.dart';
import 'package:fatatni_salah_app/hive_helper/fields/one_day_data_model_fields.dart';

part 'one_day_data.model.g.dart';

@HiveType(
    typeId: HiveTypes.oneDayDataModel,
    adapterName: HiveAdapters.oneDayDataModel)
class OneDayDataModel extends HiveObject {
  @HiveField(OneDayDataModelFields.timings)
  Timings? timings;
  @HiveField(OneDayDataModelFields.date)
  Date? date;
  @HiveField(OneDayDataModelFields.meta)
  Meta? meta;

  OneDayDataModel({this.timings, this.date, this.meta});

  factory OneDayDataModel.fromJson(Map<String, dynamic> json) {
    return OneDayDataModel(
      timings: json['timings'] == null
          ? null
          : Timings.fromJson(json['timings'] as Map<String, dynamic>),
      date: json['date'] == null
          ? null
          : Date.fromJson(json['date'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'timings': timings?.toJson(),
        'date': date?.toJson(),
        'meta': meta?.toJson(),
      };
}
