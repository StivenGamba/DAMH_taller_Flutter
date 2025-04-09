import 'package:flutter/material.dart';
import '../../core/routes.dart';
import '../../core/color.dart';
import '../../core/string.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/logo.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    AppStrings.AppNombre,
                    style: TextStyle(
                      color: AppColors.negro,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              //------------------------
              const SizedBox(height: 40),

              //------------------------
              Text(
                AppStrings.TextLogin,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.negro,
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                ),
              ),

              //------------------------

              //------------------------
              const SizedBox(height: 40),

              //------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/usuario.jpg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10), // espacio entre imagen y campo
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.negro, // Borde normal
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.blanco, // Borde al hacer focus
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.blanco,
                      ),
                      style: TextStyle(
                        color: AppColors.negro,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),

              //------------------------
              const SizedBox(height: 10),

              //------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/llave.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10), // espacio entre imagen y campo
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.negro, // Borde normal
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.blanco, // Borde al hacer focus
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.blanco,
                      ),
                      style: TextStyle(
                        color: AppColors.negro,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),

              //------------------------
              const SizedBox(height: 20),

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
                  AppStrings.ingresar,
                  style: TextStyle(color: AppColors.blanco, fontSize: 25),
                ),
              ),

              //------------------------
              const SizedBox(height: 20),

              //------------------------
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.recoverPassword);
                },
                child: Text(
                  AppStrings.RecuperaCon,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.negro,
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),


              //------------------------
              const SizedBox(height: 10),

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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icons/Google.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppStrings.IngresaGoogle,
                      style: const TextStyle(
                        color: AppColors.blanco,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),

              //------------------------
              const SizedBox(height: 10),

              //------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.NoTienescuenta,
                    style: TextStyle(color: AppColors.azulOscuro, fontSize: 16),
                  ),
                  Text(
                    AppStrings.Registrate,
                    style: TextStyle(
                      color: AppColors.blanco,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
