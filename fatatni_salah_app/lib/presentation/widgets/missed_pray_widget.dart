import 'package:fatatni_salah_app/core/utils/app_colors.dart';
import 'package:fatatni_salah_app/core/utils/app_fonts.dart';
import 'package:fatatni_salah_app/core/utils/app_strings.dart';
import 'package:fatatni_salah_app/presentation/manager/main_cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MissedPrayWidget extends StatelessWidget {
  const MissedPrayWidget(
      {super.key, required this.prayerTime, required this.prayerName});

  final String prayerName;
  final DateTime prayerTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: AppColors.liteDark),
        child: ListTile(
          title: Text(
            prayerName,
            style: AppFonts.poppinsMedium_20,
          ),
          leading: Text(
            "${prayerTime.year}\\${prayerTime.month}\\${prayerTime.day}",
            style: AppFonts.poppinsMedium_18,
          ),
          trailing: MaterialButton(
            color: AppColors.red,
            onPressed: () async {
              var box = await Hive.openBox(AppStrings.missedPrayersBox);
              print('${prayerTime.toString()}$prayerName');
              await box.delete(
                '${prayerTime.toString()}$prayerName',
              );
              BlocProvider.of<MainCubitCubit>(context).getPrayersData(context);
            },
            child: const Text('Complete'),
          ),
        ),
      ),
    );
  }
}
