import 'package:fatatni_salah_app/core/utils/app_colors.dart';
import 'package:fatatni_salah_app/presentation/views/history_view.dart';
import 'package:flutter/material.dart';

class FatatniSalah extends StatelessWidget {
  const FatatniSalah({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        child: const HistoryView(),
      ),
    );
  }
}
