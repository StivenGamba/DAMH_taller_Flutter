import 'package:flutter/material.dart';
import '../core/routes.dart';
import '../core/color.dart';
import '../core/string.dart';
import 'package:gps_app/screen/screen_login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulClaro,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/logo.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              //------------------------

              const SizedBox(height: 40),

              //------------------------
              Text(
                AppStrings.AppNombre,
                style: TextStyle(
                  color: AppColors.negro,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //------------------------

              const SizedBox(height: 40),

              //------------------------
              Text(
                AppStrings.TextHome,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.negro,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),

              //------------------------

              const SizedBox(height: 40),

              //------------------------

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.login);
                },

                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.azulOscuro,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: AppColors.blanco, width: 2))),

                //------------------
                child: const Text(
                  AppStrings.Comineza,
                  style: TextStyle(
                    color: AppColors.blanco,
                    fontSize: 25,
                  ),
                ),
              ),

              //------------------------

              const SizedBox(height: 40),

              //------------------------

              Text(
                AppStrings.Registrate,
                style: TextStyle(
                  color: AppColors.blanco,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
