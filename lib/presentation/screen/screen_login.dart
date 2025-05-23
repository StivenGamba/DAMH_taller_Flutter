import 'package:camiseta_futbolera/presentation/screen/screen_home.dart';
import 'package:camiseta_futbolera/domain/entities/user.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_inicio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/routes.dart';
import '../../core/color.dart';
import '../../core/string.dart';

class LoginScreen extends StatefulWidget {
  final GoogleSignInAccount? user;

  const LoginScreen({Key? key, this.user}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InicioScreen(user: googleUser),
            //builder: (context) => HomeScreen(),
          ),
        );
      }
    } catch (e, stackTrace) {
      // Imprimir el error y el stack trace en consola
      print('Error al iniciar sesión con Google: $e');
      print('StackTrace: $stackTrace');

      //Mostrar mensaje de error inicio de sesion
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al iniciar sesión')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
              //--------- Img Logos -----------
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

              //----------Linea  ----------
              Divider(
                color: Colors.grey,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),

              //------------------------
              const SizedBox(height: 40),

              //---------- Texto instrucciones --------------
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
              const SizedBox(height: 10),

              //-----------Imput corre -------------
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
                  const SizedBox(width: 10), // espacio entre imagen y campo
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: AppStrings.correoOtelefono,
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
                            color: AppColors.azulOscuro, // Borde al hacer focus
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
              const SizedBox(height: 15),

              //-------------Imput contraseña  ----------
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
                  const SizedBox(width: 10), // espacio entre imagen y campo
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: AppStrings.contrasena,
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
                            color: AppColors.azulOscuro, // Borde al hacer focus
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
              const SizedBox(height: 40),

              //-------------btn iniciar sesion -----------
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Routes.inicio);
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
                  AppStrings.ingresar,
                  style: TextStyle(color: AppColors.blanco, fontSize: 25),
                ),
              ),

              //------------------------
              const SizedBox(height: 20),

              //--------olvidaste la contraseña ----------------
              Text(
                AppStrings.olvidaste,
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
                  ).pushReplacementNamed(Routes.recoverPassword);
                },
                child: Text(
                  AppStrings.RecuperaCon,
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

              //--------iniciar sesion con Google ----------------
              ElevatedButton(
                onPressed:
                    _handleGoogleSignIn, // Llamada a la función de validadcion
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
