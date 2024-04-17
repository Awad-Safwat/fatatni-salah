import 'package:fatatni_salah_app/core/shared/functions.dart';
import 'package:fatatni_salah_app/core/utils/app_colors.dart';
import 'package:fatatni_salah_app/presentation/manager/main_cubit/main_cubit.dart';
import 'package:fatatni_salah_app/presentation/widgets/prayer_countdown_timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountDownCardWidget extends StatelessWidget {
  const CountDownCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Example: 15 minutes from now
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.red,
                AppColors.silver,
                AppColors.gray,
                Colors.blue,
                AppColors.green
              ]),
        ),
        height: 130.h,
        width: 320.w,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.liteDark,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Center(
              child: BlocBuilder<MainCubitCubit, MainCubitState>(
                builder: (context, state) {
                  if (state is MainCubitSucsses) {
                    return PrayerCountdownTimer(
                        nextPrayerTime: getNextPrayer()!.time);
                  } else {
                    return const Text('00:00:00');
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
