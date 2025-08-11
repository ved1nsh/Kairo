import 'package:flutter/material.dart';
import '../../Features/onboarding/IntroPages/intro_page1.dart';
import '../../Features/onboarding/IntroPages/intro_page2.dart';
import '../../Features/onboarding/IntroPages/intro_page3.dart';
import '../../Features/onboarding/Onboarding/onboarding_1.dart';
import '../../Features/onboarding/Onboarding/onboarding_2.dart';
import '../../Features/onboarding/Onboarding/onboarding_3.dart';
import '../../Features/onboarding/Onboarding/onboarding_4.dart';

class AppRoutes {
  static const String intro1 = '/intro1';
  static const String intro2 = '/intro2';
  static const String intro3 = '/intro3';
  static const String onboarding1 = '/onboarding1';
  static const String onboarding2 = '/onboarding2';
  static const String onboarding3 = '/onboarding3';
  static const String onboarding4 = '/onboarding4';
  static const String dashboard = '/dashboard';
  static const String signup = '/signup';
  static const String signin = '/signin';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      intro1: (context) => const IntroPage1(),
      intro2: (context) => const IntroPage2(),
      intro3: (context) => const IntroPage3(),
      onboarding1: (context) => const Onboarding1(),
      onboarding2: (context) => const Onboarding2(),
      onboarding3: (context) => const Onboarding3(),
      onboarding4: (context) => const Onboarding4(),
      // Add other routes as needed
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intro1:
        return MaterialPageRoute(builder: (_) => const IntroPage1());
      case intro2:
        return MaterialPageRoute(builder: (_) => const IntroPage2());
      case intro3:
        return MaterialPageRoute(builder: (_) => const IntroPage3());
      case onboarding1:
        return MaterialPageRoute(builder: (_) => const Onboarding1());
      case onboarding2:
        return MaterialPageRoute(builder: (_) => const Onboarding2());
      case onboarding3:
        return MaterialPageRoute(builder: (_) => const Onboarding3());
      case onboarding4:
        return MaterialPageRoute(builder: (_) => const Onboarding4());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
