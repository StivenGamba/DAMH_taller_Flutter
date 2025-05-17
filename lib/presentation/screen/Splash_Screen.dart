import 'package:flutter/material.dart';
import '../../core/routes.dart';
import '../../core/color.dart';
import '../../core/string.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grisClaro,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0), //
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Image.asset(
                  'assets/icons/logoEstrellas.png',
                  width:
                      MediaQuery.of(context).size.width *
                      0.5, // 70% del ancho de pantalla
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Image.asset(
                  'assets/icons/nombreApp.png',
                  width:
                      MediaQuery.of(context).size.width *
                      0.5, // 70% del ancho de pantalla
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
