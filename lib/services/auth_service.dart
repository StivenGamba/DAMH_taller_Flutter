import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/user_model.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // Verifica si el usuario está autenticado al iniciar la app
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');

    if (userData != null) {
      _currentUser = User.fromJson(jsonDecode(userData));
      notifyListeners();
      return true;
    }
    return false;
  }

  // Registrar un nuevo usuario
  Future<bool> register(String name, String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Verificar si el correo ya está registrado
      final usersData = prefs.getStringList('users') ?? [];
      for (var userData in usersData) {
        final user = User.fromJson(jsonDecode(userData));
        if (user.email == email) {
          return false; // El correo ya está registrado
        }
      }

      // Crear nuevo usuario
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        password: password,
        photoUrl: null,
      );

      // Guardar el usuario en la lista de usuarios
      usersData.add(jsonEncode(newUser.toJson()));
      await prefs.setStringList('users', usersData);

      // Establecer el usuario actual
      _currentUser = newUser;
      await prefs.setString('user_data', jsonEncode(newUser.toJson()));

      notifyListeners();
      return true;
    } catch (e) {
      print('Error al registrar usuario: $e');
      return false;
    }
  }

  // Iniciar sesión con email y contraseña
  Future<bool> login(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Buscar el usuario en la lista de usuarios
      final usersData = prefs.getStringList('users') ?? [];
      for (var userData in usersData) {
        final user = User.fromJson(jsonDecode(userData));
        if (user.email == email && user.password == password) {
          // Usuario encontrado, establecer como usuario actual
          _currentUser = user;
          await prefs.setString('user_data', jsonEncode(user.toJson()));
          notifyListeners();
          return true;
        }
      }

      return false; // Usuario no encontrado o contraseña incorrecta
    } catch (e) {
      print('Error al iniciar sesión: $e');
      return false;
    }
  }

  // Iniciar sesión con Google (mantener usuario)
  Future<bool> loginWithGoogle(User googleUser) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Verificar si el usuario ya existe en nuestra base de datos
      final usersData = prefs.getStringList('users') ?? [];
      bool userExists = false;

      for (var userData in usersData) {
        final user = User.fromJson(jsonDecode(userData));
        if (user.email == googleUser.email) {
          // Actualizar información del usuario si existe
          userExists = true;
          user.name = googleUser.name;
          user.photoUrl = googleUser.photoUrl;

          // Reemplazar en la lista
          int index = usersData.indexWhere((ud) {
            return User.fromJson(jsonDecode(ud)).email == user.email;
          });

          if (index >= 0) {
            usersData[index] = jsonEncode(user.toJson());
            await prefs.setStringList('users', usersData);
          }

          _currentUser = user;
          await prefs.setString('user_data', jsonEncode(user.toJson()));
          break;
        }
      }

      // Si el usuario no existe, crearlo
      if (!userExists) {
        usersData.add(jsonEncode(googleUser.toJson()));
        await prefs.setStringList('users', usersData);

        _currentUser = googleUser;
        await prefs.setString('user_data', jsonEncode(googleUser.toJson()));
      }

      notifyListeners();
      return true;
    } catch (e) {
      print('Error al iniciar sesión con Google: $e');
      return false;
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    _currentUser = null;
    notifyListeners();
  }
}
