// lib/services/auth_service.dart
import 'dart:convert';
import 'package:camiseta_futbolera/data/models/user_model.dart' as local_user;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import '../data/models/user_model.dart';
import '../config/supabase_config.dart';
import '../config/supabase_config.dart';

class AuthService extends ChangeNotifier {
  final _supabase = SupabaseConfig.client;
  User? _currentUser;

  local_user.User? get currentUser => _currentUser;

  // Verifica si el usuario está autenticado al iniciar la app
  Future<bool> isAuthenticated() async {
    try {
      // Primero verificar si hay una sesión activa en Supabase
      final session = _supabase.auth.currentSession;
      if (session != null) {
        // Obtener datos del usuario desde la tabla usuario
        final userData =
            await _supabase
                .from('usuario')
                .select('*')
                .eq('string_email', session.user.email!)
                .single();

        _currentUser = User(
          id: userData['user_id'].toString(),
          name: userData['string_nombre'],
          email: userData['string_email'],
          photoUrl: userData['string_foto_url'],
        );

        // También guardar localmente como respaldo
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(_currentUser!.toJson()));

        notifyListeners();
        return true;
      }

      // Si no hay sesión en Supabase, verificar SharedPreferences como respaldo
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user_data');

      if (userData != null) {
        _currentUser = User.fromJson(jsonDecode(userData));
        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      print('Error al verificar autenticación: $e');
      // Si falla, usar solo el método local
      return await _isAuthenticatedLocal();
    }
  }

  // Registrar un nuevo usuario
  Future<bool> register(String name, String email, String password) async {
    try {
      // 1. Registrar en Supabase Auth
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        return false; // Error en el registro
      }

      // 2. Guardar información adicional en la tabla usuario
      await _supabase.from('usuario').insert({
        'user_id': authResponse.user!.id,
        'string_nombre': name,
        'string_email': email,
        'string_telefono': null,
        'string_direccion': null,
        'string_foto_url': null,
        'boolean_activo': true,
      });

      // 3. Crear objeto User local
      final newUser = User(
        id: authResponse.user!.id,
        name: name,
        email: email,
        photoUrl: null,
      );

      // 4. Establecer el usuario actual
      _currentUser = newUser;

      // 5. Guardar localmente como respaldo
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(newUser.toJson()));

      // 6. También guardar en la lista local de usuarios (tu método original)
      await _saveUserToLocalList(newUser, password);

      notifyListeners();
      return true;
    } catch (e) {
      print('Error al registrar usuario en Supabase: $e');
      // Si falla Supabase, usar el método local original
      return await _registerLocal(name, email, password);
    }
  }

  // Iniciar sesión con email y contraseña
  Future<bool> login(String email, String password) async {
    try {
      // 1. Intentar iniciar sesión en Supabase
      final authResponse = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (authResponse.user != null) {
        // 2. Obtener datos adicionales del usuario
        final userData =
            await _supabase
                .from('usuario')
                .select('*')
                .eq('string_email', email)
                .single();

        // 3. Crear objeto User
        final user = User(
          id: userData['user_id'].toString(),
          name: userData['string_nombre'],
          email: userData['string_email'],
          photoUrl: userData['string_foto_url'],
        );

        // 4. Establecer usuario actual
        _currentUser = user;

        // 5. Guardar localmente
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(user.toJson()));

        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      print('Error al iniciar sesión en Supabase: $e');
      // Si falla Supabase, usar el método local original
      return await _loginLocal(email, password);
    }
  }

  // Iniciar sesión con Google (tu método original mejorado)
  Future<bool> loginWithGoogle(User googleUser) async {
    try {
      // 1. Verificar si el usuario existe en Supabase
      final existingUser =
          await _supabase
              .from('usuario')
              .select('*')
              .eq('string_email', googleUser.email)
              .maybeSingle();

      if (existingUser != null) {
        // Usuario existe, actualizar información
        await _supabase
            .from('usuario')
            .update({
              'string_nombre': googleUser.name,
              'string_foto_url': googleUser.photoUrl,
            })
            .eq('string_email', googleUser.email);

        _currentUser = User(
          id: existingUser['user_id'].toString(),
          name: googleUser.name,
          email: googleUser.email,
          photoUrl: googleUser.photoUrl,
        );
      } else {
        // Usuario no existe, crearlo
        final newUserData =
            await _supabase
                .from('usuario')
                .insert({
                  'string_nombre': googleUser.name,
                  'string_email': googleUser.email,
                  'string_foto_url': googleUser.photoUrl,
                  'boolean_activo': true,
                })
                .select()
                .single();

        _currentUser = User(
          id: newUserData['user_id'].toString(),
          name: googleUser.name,
          email: googleUser.email,
          photoUrl: googleUser.photoUrl,
        );
      }

      // Guardar localmente
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(_currentUser!.toJson()));

      // También guardar en la lista local (tu método original)
      await _saveUserToLocalList(_currentUser!, null);

      notifyListeners();
      return true;
    } catch (e) {
      print('Error al iniciar sesión con Google en Supabase: $e');
      // Usar método local original como respaldo
      return await _loginWithGoogleLocal(googleUser);
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    try {
      // Cerrar sesión en Supabase
      await _supabase.auth.signOut();
    } catch (e) {
      print('Error al cerrar sesión en Supabase: $e');
    }

    // Limpiar datos locales (tu método original)
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    _currentUser = null;
    notifyListeners();
  }

  // Actualizar perfil del usuario
  Future<bool> updateProfile(String name, String? photoUrl) async {
    if (_currentUser == null) return false;

    try {
      // Actualizar en Supabase
      await _supabase
          .from('usuario')
          .update({'string_nombre': name, 'string_foto_url': photoUrl})
          .eq('string_email', _currentUser!.email);

      // Actualizar usuario local
      _currentUser = _currentUser!.copyWith(name: name, photoUrl: photoUrl);

      // Guardar localmente
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(_currentUser!.toJson()));

      // Actualizar en la lista local también
      await _updateUserInLocalList(_currentUser!);

      notifyListeners();
      return true;
    } catch (e) {
      print('Error al actualizar perfil: $e');
      return false;
    }
  }

  // ===== MÉTODOS LOCALES ORIGINALES (RESPALDO) =====

  Future<bool> _isAuthenticatedLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user_data');

    if (userData != null) {
      _currentUser = User.fromJson(jsonDecode(userData));
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> _registerLocal(
    String name,
    String email,
    String password,
  ) async {
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
      print('Error al registrar usuario localmente: $e');
      return false;
    }
  }

  Future<bool> _loginLocal(String email, String password) async {
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
      print('Error al iniciar sesión localmente: $e');
      return false;
    }
  }

  Future<bool> _loginWithGoogleLocal(User googleUser) async {
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
      print('Error al iniciar sesión con Google localmente: $e');
      return false;
    }
  }

  // Método auxiliar para guardar usuario en lista local
  Future<void> _saveUserToLocalList(User user, String? password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersData = prefs.getStringList('users') ?? [];

      // Crear una copia del usuario con contraseña si se proporciona
      final userWithPassword = local_user.User(
        id: user.id,
        name: user.name,
        email: user.email,
        photoUrl: user.photoUrl,
        password: password,
      );

      // Verificar si ya existe y actualizar, o agregar nuevo
      int existingIndex = usersData.indexWhere((userData) {
        final existingUser = local_user.User.fromJson(jsonDecode(userData));
        return existingUser.email == user.email;
      });

      if (existingIndex >= 0) {
        // Actualizar usuario existente
        usersData[existingIndex] = jsonEncode(userWithPassword.toJson());
      } else {
        // Agregar nuevo usuario
        usersData.add(jsonEncode(userWithPassword.toJson()));
      }

      await prefs.setStringList('users', usersData);
    } catch (e) {
      print('Error al guardar usuario en lista local: $e');
    }
  }

  // Método auxiliar para actualizar usuario en lista local
  Future<void> _updateUserInLocalList(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersData = prefs.getStringList('users') ?? [];

      // Buscar y actualizar el usuario
      for (int i = 0; i < usersData.length; i++) {
        final existingUser = User.fromJson(jsonDecode(usersData[i]));
        if (existingUser.email == user.email) {
          // Mantener la contraseña existente
          final updatedUser = user.copyWith(
            password: existingUser.password,
          ); // Note: This line is already correct as it uses the local_user.User type implicitly
          usersData[i] = jsonEncode(updatedUser.toJson());
          break;
        }
      }

      await prefs.setStringList('users', usersData);
    } catch (e) {
      print('Error al actualizar usuario en lista local: $e');
    }
  }

  // Sincronizar datos locales con Supabase
  Future<bool> syncLocalDataToSupabase() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersData = prefs.getStringList('users') ?? [];
      int syncedUsers = 0;

      for (var userData in usersData) {
        final user = User.fromJson(jsonDecode(userData));

        // Verificar si el usuario ya existe en Supabase
        final existingUser =
            await _supabase
                .from('usuario')
                .select('*')
                .eq('string_email', user.email)
                .maybeSingle();

        if (existingUser == null) {
          // Usuario no existe en Supabase, crearlo
          await _supabase.from('usuario').insert({
            'string_nombre': user.name,
            'string_email': user.email,
            'string_foto_url': user.photoUrl,
            'boolean_activo': true,
          });
          syncedUsers++;
        }
      }

      print('Sincronizados $syncedUsers usuarios a Supabase');
      return true;
    } catch (e) {
      print('Error al sincronizar datos: $e');
      return false;
    }
  }

  // Método para obtener estadísticas de usuarios
  Future<Map<String, int>> getUserStats() async {
    try {
      final localUsers = await _getLocalUsersCount();
      final supabaseUsers = await _getSupabaseUsersCount();

      return {'local': localUsers, 'supabase': supabaseUsers};
    } catch (e) {
      print('Error al obtener estadísticas: $e');
      return {'local': 0, 'supabase': 0};
    }
  }

  Future<int> _getLocalUsersCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersData = prefs.getStringList('users') ?? [];
      return usersData.length;
    } catch (e) {
      return 0;
    }
  }

  Future<int> _getSupabaseUsersCount() async {
    try {
      final response =
          await _supabase.from('usuario').select('user_id').count();
      return response.count;
    } catch (e) {
      return 0;
    }
  }
}
