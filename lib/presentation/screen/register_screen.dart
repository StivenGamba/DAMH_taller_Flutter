import 'package:camiseta_futbolera/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/routes.dart';
import '../../core/color.dart';
import '../../core/string.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_login.dart';

// Cambiar de StatelessWidget a StatefulWidget
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controladores para los campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Estado para mostrar indicador de carga
  bool _isRegistering = false;

  @override
  void dispose() {
    // Liberar los controladores cuando se destruye el widget
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grisClaro,
      body: SingleChildScrollView(
        child: Center(
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
                        controller: _nameController, // Añadir controlador
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
                        controller: _lastNameController, // Añadir controlador
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
                        controller: _emailController, // Añadir controlador
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
                        controller: _phoneController, // Añadir controlador
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
                        controller: _passwordController, // Añadir controlador
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
                        controller:
                            _confirmPasswordController, // Añadir controlador
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
                  onPressed:
                      _isRegistering
                          ? null // Deshabilitar el botón mientras se procesa el registro
                          : () async {
                            // Validar campos
                            if (_nameController.text.isEmpty ||
                                _emailController.text.isEmpty ||
                                _passwordController.text.isEmpty ||
                                _confirmPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Por favor, complete todos los campos',
                                  ),
                                ),
                              );
                              return;
                            }

                            // Verificar que las contraseñas coincidan
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Las contraseñas no coinciden'),
                                ),
                              );
                              return;
                            }

                            // Mostrar indicador de carga
                            setState(() {
                              _isRegistering = true;
                            });

                            try {
                              // Crear nombre completo
                              String fullName = _nameController.text;
                              if (_lastNameController.text.isNotEmpty) {
                                fullName += " " + _lastNameController.text;
                              }

                              // Registrar al usuario usando AuthService
                              final authService = Provider.of<AuthService>(
                                context,
                                listen: false,
                              );
                              final success = await authService.register(
                                fullName,
                                _emailController.text,
                                _passwordController.text,
                              );

                              if (success) {
                                // Registro exitoso, navegar a la pantalla de inicio
                                Navigator.pushReplacementNamed(
                                  context,
                                  Routes.inicio,
                                );
                              } else {
                                // Error en el registro
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'El correo ya está registrado o ocurrió un error',
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              // Manejar errores
                              print('Error durante el registro: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Ocurrió un error durante el registro',
                                  ),
                                ),
                              );
                            } finally {
                              // Asegurarse de que se actualice el estado
                              if (mounted) {
                                setState(() {
                                  _isRegistering = false;
                                });
                              }
                            }
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

                  // Mostrar indicador de carga o texto del botón
                  child:
                      _isRegistering
                          ? CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            AppStrings.Registrate,
                            style: TextStyle(
                              color: AppColors.blanco,
                              fontSize: 25,
                            ),
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
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(Routes.login);
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
      ),
    );
  }
}
