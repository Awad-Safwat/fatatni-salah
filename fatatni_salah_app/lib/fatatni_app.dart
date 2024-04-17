import 'package:fatatni_salah_app/core/utils/app_colors.dart';
import 'package:fatatni_salah_app/presentation/views/missed_prayers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FatatniSalah extends StatelessWidget {
  const FatatniSalah({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 890),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(color: Colors.transparent),
        ),
        themeMode: ThemeMode.system,
        home: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.liteDark,
                AppColors.deepDark,
                AppColors.black,
              ],
            ),
          ),
          child: const MissedPrayersView(),
        ),
      ),
    );
  }
}
