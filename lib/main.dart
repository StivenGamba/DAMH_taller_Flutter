import 'package:camiseta_futbolera/presentation/screen/cart_screen.dart';
import 'package:camiseta_futbolera/presentation/screen/category_screen.dart';
import 'package:camiseta_futbolera/presentation/screen/edit_profile_screen.dart';
import 'package:camiseta_futbolera/presentation/screen/favorites_screen.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_inicio.dart';
import 'package:camiseta_futbolera/presentation/screen/profile_screen.dart';
import 'package:camiseta_futbolera/presentation/screen/product_detail_screen.dart';
import 'package:camiseta_futbolera/services/auth_service.dart';
import 'package:camiseta_futbolera/presentation/screen/register_screen.dart';
import 'package:camiseta_futbolera/presentation/screen/terms_screen.dart';
import 'package:camiseta_futbolera/presentation/screen/validarCodigo_screen.dart';
import 'package:camiseta_futbolera/services/favorite_service.dart';
import 'package:flutter/material.dart';
import 'package:camiseta_futbolera/presentation/screen/Splash_Screen.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_home.dart';
import 'package:camiseta_futbolera/presentation/screen/screen_login.dart';
import 'package:camiseta_futbolera/presentation/screen/password_recovery_screen.dart';
import 'package:camiseta_futbolera/data/models/user_model.dart';
import 'package:provider/provider.dart';
import 'core/routes.dart';
import 'core/string.dart';
import 'core/color.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

void main() async {
  // Asegurarse de que las dependencias de Flutter estén inicializadas
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar servicios
  final authService = AuthService();
  final favoriteService = FavoriteService();

  // Verificar si hay un usuario autenticado
  await authService.isAuthenticated();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: favoriteService),
        ChangeNotifierProvider.value(value: authService),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.AppNombre,
      debugShowCheckedModeBanner: false, // Quita el banner de debug
      initialRoute: Routes.splash,

      // Rutas predefinidas
      routes: {
        Routes.splash: (context) => const SplashScreen(),
        Routes.home: (context) => const HomeScreen(),
        Routes.login: (context) => const LoginScreen(),
        Routes.register: (context) => const RegisterScreen(),
        Routes.recoverPassword: (context) => const RecoverPasswordScreen(),
        Routes.validarCodigo: (context) => const ValidarCodigoScreen(),
        Routes.categories: (context) => const CategoryScreen(),
        Routes.favorites: (context) => const FavoritesScreen(),
        Routes.cart: (context) => const CartScreen(),
        Routes.terms: (context) => const TermsScreen(),
      },

      // Generador para rutas que necesitan parámetros
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.inicio:
            return MaterialPageRoute(
              builder: (context) {
                final authService = Provider.of<AuthService>(
                  context,
                  listen: false,
                );
                return InicioScreen(currentUser: authService.currentUser);
              },
            );

          case Routes.profile:
            return MaterialPageRoute(
              builder: (context) {
                final authService = Provider.of<AuthService>(
                  context,
                  listen: false,
                );
                return ProfileScreen();
              },
            );

          case Routes.editProfile:
            final currentUser = settings.arguments as User?;
            return MaterialPageRoute(
              builder: (context) => EditProfileScreen(currentUser: currentUser),
            );

          case Routes.productDetail:
            final product = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            );

          default:
            // Si la ruta no está definida, redirigir a home
            return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
      },

      // Definición del tema de la aplicación
      theme: ThemeData(
        // Colores principales
        primaryColor: AppColors.azulOscuro,
        scaffoldBackgroundColor: Colors.white,

        // Esquema de colores
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.azulOscuro,
          primary: AppColors.azulOscuro,
          secondary: AppColors.azulClaro,
          tertiary: AppColors.grisOsecuro,
          background: Colors.white,
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: Colors.black,
          onSurface: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),

        // Tema para AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.azulOscuro,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),

        // Tema para botones elevados
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.azulOscuro,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
        ),

        // Tema para botones de contorno
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.azulOscuro,
            side: const BorderSide(color: AppColors.azulOscuro),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Tema para botones de texto
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.azulOscuro,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),

        // Tema para campos de texto
        inputDecorationTheme: InputDecorationTheme(
          filled: false,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.azulOscuro, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),

        // Tema para tarjetas
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),

        // Tema para diálogos
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
        ),

        // Tema para barras de navegación
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.azulOscuro,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
      ),

      // Por defecto usar tema claro
      themeMode: ThemeMode.light,
    );
  }
}
