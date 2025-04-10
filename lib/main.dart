import 'package:flutter/material.dart';
import 'package:gps_app/screen/Splash_Screen.dart';
import 'package:gps_app/screen/screen_home.dart';
import 'package:gps_app/screen/screen_login.dart';
import 'core/routes.dart';
import 'core/string.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.AppNombre,
      initialRoute: Routes.splash,
      routes: {
        Routes.splash: (context) => const SplashScreen(),
        Routes.home: (context) => const HomeScreen(),
        Routes.login: (context) => const LoginScreen(),
      },
    );
  }
}
