import 'package:flutter/material.dart';
import '../../core/routes.dart';
import '../../core/color.dart';
import '../../core/string.dart';

class validarCodigoScreen extends StatelessWidget {
  const validarCodigoScreen({Key? key}) : super(key: key);

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
              const SizedBox(height: 20),

              //------------------------
              Text(
                AppStrings.validarCodigodigitos,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.negro,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),

              //------------------------
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 45,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        counterText: "", // Oculta el contador de caracteres
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
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
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: AppColors.blanco, width: 2),
                  ),
                ),

                //------------------
                child: const Text(
                  AppStrings.verificar,
                  style: TextStyle(color: AppColors.blanco, fontSize: 25),
                ),
              ),

              //------------------------
              const SizedBox(height: 20),

              //------------------------
              Text(
                AppStrings.solicitarNuevoCodigo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.negro,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              //------------------------RECUPERAR CONTRA
              const SizedBox(height: 0),

              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(Routes.validarCodigo);
                },
                child: Text(
                  AppStrings.generarNuevoCodigo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.azulClaro,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.azulClaro,
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

              //------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.NoTienescuenta,
                    style: TextStyle(color: AppColors.negro, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(Routes.register);
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
            ],
          ),
        ),
      ),
    );
  }
}
