import 'package:face_diseases_app/Pages/dashboard.dart';
import 'package:face_diseases_app/Pages/homePage.dart';
import 'package:flutter/material.dart';

import '../Login/screens/create_password/ui/create_password.dart';
import '../Login/screens/forget/ui/forget_screen.dart';
import '../Login/screens/home/ui/home_sceren.dart';
import '../Login/screens/login/ui/login_screen.dart';
import '../Login/screens/signup/ui/sign_up_sceen.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.forgetScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgetScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) =>  ProfilePage(),
        );
        case Routes.dashboard:
        return MaterialPageRoute(
          builder: (_) => Dashboard(),
        );
        case Routes.homePage:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case Routes.createPassword:
        final arguments = settings.arguments;
        if (arguments is List) {
          return MaterialPageRoute(
            builder: (_) => CreatePassword(
              googleUser: arguments[0],
              credential: arguments[1],
            ),
          );
        }
        return null;
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
    }
    return null;
  }
}