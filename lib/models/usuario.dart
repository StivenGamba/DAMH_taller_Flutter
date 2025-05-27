class Usuario {
  final int userId;
  final String stringNombre;
  final String stringEmail;
  final String? stringDireccion;
  final String? stringTelefono;
  final bool booleanActivo;

  Usuario({
    required this.userId,
    required this.stringNombre,
    required this.stringEmail,
    this.stringDireccion,
    this.stringTelefono,
    this.booleanActivo = true,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      userId: json['user_id'],
      stringNombre: json['string_nombre'] ?? '',
      stringEmail: json['string_email'] ?? '',
      stringDireccion: json['string_direccion'],
      stringTelefono: json['string_telefono'],
      booleanActivo: json['boolean_activo'] ?? true,
    );
  }
}
