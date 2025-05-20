import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String id;
  String name;
  final String email;
  String? photoUrl;
  String? password;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.password,
  });

  // Crear un usuario desde un mapa JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'],
      password: json['password'],
    );
  }

  // Convertir este usuario a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'password': password,
    };
  }

  // Alias para mantener compatibilidad con código existente
  factory User.fromMap(Map<String, dynamic> map) => User.fromJson(map);
  Map<String, dynamic> toMap() => toJson();

  // Método para crear una copia con algunos cambios
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      password: password ?? this.password,
    );
  }

  static User fromGoogle(GoogleSignInAccount googleUser) {
    return User(
      id: googleUser.id,
      name: googleUser.displayName ?? 'Usuario',
      email: googleUser.email,
      photoUrl: googleUser.photoUrl,
    );
  }
}
