import 'package:fatatni_salah_app/data/models/one_day_data_model/date.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/designation.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/gregorian.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/hijri.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/location.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/meta.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/method.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/month.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/offset.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/one_day_data.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/params.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/timings.model.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/weekday.model.dart';
import 'package:hive/hive.dart';
import 'package:fatatni_salah_app/data/models/one_day_data_model/prayer_model.dart';

void registerAdapters() {
  Hive.registerAdapter(DateAdapter());
  Hive.registerAdapter(DesignationAdapter());
  Hive.registerAdapter(GregorianAdapter());
  Hive.registerAdapter(HijriAdapter());
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(MetaAdapter());
  Hive.registerAdapter(MethodAdapter());
  Hive.registerAdapter(MonthAdapter());
  Hive.registerAdapter(OffsetAdapter());
  Hive.registerAdapter(OneDayDataModelAdapter());
  Hive.registerAdapter(ParamsAdapter());
  Hive.registerAdapter(TimingsAdapter());
  Hive.registerAdapter(WeekdayAdapter());
	Hive.registerAdapter(PrayerAdapter());
}
