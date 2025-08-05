import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kairo/Onboarding/onboarding_1.dart';
import 'package:kairo/Onboarding/onboarding_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852), // Same as your Figma frame
      minTextAdapt: true, // Ensures text scales well
      splitScreenMode: true, // For tablets/split-screen
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Onboarding1(),
          routes: {'/onboarding2': (context) => const Onboarding2()},
        );
      },
    );
  }
}
