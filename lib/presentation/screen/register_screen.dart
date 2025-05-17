import 'package:flutter/material.dart';
import '../../core/routes.dart';
import '../../core/color.dart';
import '../../core/string.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
              const SizedBox(height: 40),

              //------------------------
              Text(
                AppStrings.textRegister,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.negro,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),

              //------------------------
              const SizedBox(height: 10),

              // NOMBRE
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/usuario.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: AppStrings.nombre,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.negro,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.azulOscuro,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.blanco,
                      ),
                      style: TextStyle(color: AppColors.negro, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // APELLIDO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/usuario.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: AppStrings.apellido,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.negro,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.azulOscuro,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.blanco,
                      ),
                      style: TextStyle(color: AppColors.negro, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // CORREO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/email.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: AppStrings.correoRe,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.negro,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.azulOscuro,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.blanco,
                      ),
                      style: TextStyle(color: AppColors.negro, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // TELÉFONO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/telefono.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: AppStrings.telefono,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.negro,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.azulOscuro,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.blanco,
                      ),
                      style: TextStyle(color: AppColors.negro, fontSize: 18),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // CONTRASEÑA
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/contrasena.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: AppStrings.contrasenaRe,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.negro,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.azulOscuro,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.blanco,
                      ),
                      style: TextStyle(color: AppColors.negro, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // CONFIRMAR CONTRASEÑA
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/contrasena.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: AppStrings.confirmarContrasena,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.negro,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.azulOscuro,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.blanco,
                      ),
                      style: TextStyle(color: AppColors.negro, fontSize: 18),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              //------------------------
              //------------------------
              Text(
                AppStrings.tyc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.negro,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
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
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: AppColors.blanco, width: 2),
                  ),
                ),

                //------------------
                child: const Text(
                  AppStrings.Registrate,
                  style: TextStyle(color: AppColors.blanco, fontSize: 25),
                ),
              ),

              //------------------------
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.yaTienesCuenta,
                    style: TextStyle(
                      color: AppColors.negro,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(Routes.login);
                    },
                    child: Text(
                      AppStrings.IniciarSesion,
                      style: TextStyle(
                        color: AppColors.azulClaro,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.azulClaro,
                      ),
                    ),
                  ),
                ],
              ),

              //------------------------
              const SizedBox(height: 10),

              //------------------------
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blanco,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: AppColors.grisOsecuro, width: 2),
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
                        color: AppColors.grisOsecuro,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),

              //------------------------
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
