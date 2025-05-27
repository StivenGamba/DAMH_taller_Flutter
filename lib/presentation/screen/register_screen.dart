// lib/presentation/screen/register_screen.dart
import 'package:camiseta_futbolera/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/routes.dart';
import '../../core/color.dart';
import '../../core/string.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_login.dart';

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

  // Método para limpiar todos los campos
  void _clearFields() {
    _nameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }

  // Validar email
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Manejar el registro
  Future<void> _handleRegister() async {
    // Validar campos obligatorios
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showSnackBar(
        'Por favor, complete todos los campos obligatorios',
        Colors.red,
      );
      return;
    }

    // Validar email
    if (!_isValidEmail(_emailController.text.trim())) {
      _showSnackBar('Por favor, ingrese un email válido', Colors.red);
      return;
    }

    // Validar contraseñas coincidan
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Las contraseñas no coinciden', Colors.red);
      return;
    }

    // Validar longitud de contraseña
    if (_passwordController.text.length < 6) {
      _showSnackBar(
        'La contraseña debe tener al menos 6 caracteres',
        Colors.orange,
      );
      return;
    }

    // Iniciar proceso de registro
    setState(() {
      _isRegistering = true;
    });

    try {
      // Crear nombre completo
      String fullName = _nameController.text.trim();
      if (_lastNameController.text.trim().isNotEmpty) {
        fullName += " " + _lastNameController.text.trim();
      }

      // Registrar al usuario usando AuthService
      final authService = Provider.of<AuthService>(context, listen: false);
      final success = await authService.register(
        fullName,
        _emailController.text.trim().toLowerCase(),
        _passwordController.text,
      );

      if (success) {
        // Registro exitoso
        _showSnackBar('¡Registro exitoso! Bienvenido $fullName', Colors.green);

        // Limpiar campos
        _clearFields();

        // Pequeña pausa para mostrar el mensaje
        await Future.delayed(Duration(milliseconds: 1500));

        // Navegar a la pantalla de inicio
        if (mounted) {
          Navigator.pushReplacementNamed(context, Routes.inicio);
        }
      } else {
        // Error en el registro
        _showSnackBar(
          'El correo ya está registrado. Intenta con otro email.',
          Colors.orange,
        );
      }
    } catch (e) {
      print('Error durante el registro: $e');

      // Mostrar error más específico
      String errorMessage = 'Ocurrió un error durante el registro';

      if (e.toString().toLowerCase().contains('email')) {
        errorMessage = 'Error con el email. Verifica que sea válido.';
      } else if (e.toString().toLowerCase().contains('password')) {
        errorMessage =
            'Error con la contraseña. Debe tener al menos 6 caracteres.';
      } else if (e.toString().toLowerCase().contains('network') ||
          e.toString().toLowerCase().contains('connection')) {
        errorMessage =
            'Error de conexión. Verifica tu internet e intenta de nuevo.';
      } else if (e.toString().toLowerCase().contains('weak')) {
        errorMessage = 'La contraseña es muy débil. Usa una más segura.';
      }

      _showSnackBar(errorMessage, Colors.red);
    } finally {
      // Asegurarse de que se actualice el estado
      if (mounted) {
        setState(() {
          _isRegistering = false;
        });
      }
    }
  }

  // Método para mostrar SnackBar
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Manejar Google Sign In
  Future<void> _handleGoogleSignIn() async {
    try {
      // Por ahora mostrar mensaje de que viene próximamente
      _showSnackBar('Google Sign In próximamente disponible', Colors.blue);

      // CUANDO IMPLEMENTES GOOGLE SIGN IN, DESCOMENTA ESTO:
      /*
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      
      if (googleUser != null) {
        final User user = User.fromGoogle(googleUser);
        final authService = Provider.of<AuthService>(context, listen: false);
        final success = await authService.loginWithGoogle(user);
        
        if (success) {
          _showSnackBar('¡Bienvenido ${user.name}!', Colors.green);
          await Future.delayed(Duration(milliseconds: 1000));
          Navigator.pushReplacementNamed(context, Routes.inicio);
        } else {
          _showSnackBar('Error al conectar con Google', Colors.red);
        }
      }
      */
    } catch (e) {
      print('Error con Google Sign In: $e');
      _showSnackBar('Error al conectar con Google', Colors.red);
    }
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
                const SizedBox(height: 50), // Espacio superior
                // Logo de la app
                Image.asset(
                  'assets/icons/logoEstrellas.png',
                  width: MediaQuery.of(context).size.width * 0.15,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),

                // Nombre de la app
                Image.asset(
                  'assets/icons/nombreApp.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 15),

                // Divisor
                Divider(
                  color: Colors.grey,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),

                const SizedBox(height: 40),

                // Título de registro
                Text(
                  AppStrings.textRegister,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.negro,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(height: 10),

                // CAMPO NOMBRE
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
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red, width: 2),
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

                // CAMPO APELLIDO
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
                        controller: _lastNameController,
                        textCapitalization: TextCapitalization.words,
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

                // CAMPO EMAIL
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red, width: 2),
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

                // CAMPO TELÉFONO
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
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
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

                // CAMPO CONTRASEÑA
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
                        controller: _passwordController,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red, width: 2),
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

                // CAMPO CONFIRMAR CONTRASEÑA
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
                        controller: _confirmPasswordController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _handleRegister(),
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.red, width: 2),
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

                // Términos y condiciones
                Text(
                  AppStrings.tyc,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.negro,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(height: 20),

                // BOTÓN DE REGISTRO
                ElevatedButton(
                  onPressed: _isRegistering ? null : _handleRegister,
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
                  child:
                      _isRegistering
                          ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Registrando...',
                                style: TextStyle(
                                  color: AppColors.blanco,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )
                          : const Text(
                            AppStrings.Registrate,
                            style: TextStyle(
                              color: AppColors.blanco,
                              fontSize: 25,
                            ),
                          ),
                ),

                const SizedBox(height: 10),

                // Enlace para ir a login
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

                const SizedBox(height: 10),

                // BOTÓN GOOGLE SIGN IN
                ElevatedButton(
                  onPressed: _handleGoogleSignIn,
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

                const SizedBox(height: 30), // Espacio inferior
              ],
            ),
          ),
        ),
      ),
    );
  }
}
