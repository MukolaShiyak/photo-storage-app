import 'package:flutter/material.dart';

import '/presentation/pages/sign_in/sign_in_screen.dart';
import '/presentation/pages/sign_up/sign_up_screen.dart';
import '/presentation/pages/home_screen/home_screen.dart';
import '/presentation/pages/splash_screen/spash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String homeScreen = '/homeScreen';

  Route<dynamic>? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case '/signUp':
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );
      case '/signIn':
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );
      case '/homeScreen':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
    }
    return null;
  }
}
