import 'package:corebornassessmenttask/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Assessment Task',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ThemeData().colorScheme.copyWith(primary: const Color(0xFF07122A), brightness: Brightness.light),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          useMaterial3: false,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
