import 'package:flutter/material.dart';
import '../../core/routes.dart';
import '../../core/color.dart';
import '../../core/string.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grisClaro,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/icons/logoEstrellas.png',
                width: MediaQuery.of(context).size.width * 0.15, //
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/icons/nombreApp.png',
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.contain,
              ),

              //------------------------
              const SizedBox(height: 15),

              //------------------------
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),

              //------------------------

              //------------------------
              const SizedBox(height: 40),

              //------------------------
              Text(
                AppStrings.TextHome,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.negro,
                  fontSize: 18,
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
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: AppColors.blanco, width: 2),
                  ),
                ),

                //------------------
                child: const Text(
                  AppStrings.Comineza,
                  style: TextStyle(color: AppColors.blanco, fontSize: 25),
                ),
              ),

              //------------------------
              const SizedBox(height: 40),

              //------------------------
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.register);
                },
                child: Text(
                  AppStrings.Registrate,
                  style: TextStyle(
                    color: AppColors.azulClaro,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.azulClaro,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
