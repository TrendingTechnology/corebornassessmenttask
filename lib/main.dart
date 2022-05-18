import 'package:corebornassessmenttask/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'providers/main_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
        themeMode: ThemeMode.system,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: const Color(0xFF87CEFA),
                onPrimary: Colors.black,
                brightness: Brightness.dark,
              ),
          backgroundColor: Colors.black.withOpacity(0.7),
          scaffoldBackgroundColor: Colors.black,
          useMaterial3: false,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(),
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ThemeData().colorScheme.copyWith(primary: const Color(0xFF07122A), brightness: Brightness.light),
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: const Color(0xFFF5F5F7),
          useMaterial3: false,
          fontFamily: 'Poppins',
          textTheme: const TextTheme(),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
