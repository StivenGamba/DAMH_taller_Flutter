import 'package:camiseta_futbolera/presentation/screen/register_screen.dart';
import 'package:camiseta_futbolera/presentation/screen/validarCodigo_screen.dart';
import 'package:flutter/material.dart';
import 'package:camiseta_futbolera/presentation/screen/Splash_Screen.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_home.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_login.dart';
import 'package:camiseta_futbolera/presentation/screen/password_recovery_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        Routes.recoverPassword: (context) => const RecoverPasswordScreen(),
        Routes.validarCodigo: (context) => const validarCodigoScreen(),
        Routes.register: (context) => const RegisterScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/login') {
          final args = settings.arguments as GoogleSignInAccount?;
          return MaterialPageRoute(
            builder: (context) {
              return LoginScreen(user: args!);
            },
          );
        }

        return null;
      },
    );
  }
}
