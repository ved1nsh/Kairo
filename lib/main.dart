import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routes/routes.dart';
import 'Features/onboarding/IntroPages/intro_page1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // Same as your Figma frame
      minTextAdapt: true, // Ensures text scales well
      splitScreenMode: true, // For tablets/split-screen
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const IntroPage1(), // Start with intro page
          routes: AppRoutes.getRoutes(),
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
