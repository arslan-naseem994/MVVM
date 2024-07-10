import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/view/home_view.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/signup_view.dart';
import 'package:mvvm/view/splash_view.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
// cases section
      case RoutesNames.home:
        return MaterialPageRoute(
            builder: ((context) => const HomeScreen(
                // data: settings.arguments as Map,
                )));
      case RoutesNames.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesNames.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignUpScreen());

      case RoutesNames.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
// default
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Column(
              children: [
                Center(
                  child: Text('No route defined'),
                )
              ],
            ),
          );
        });
    }
  }
}
