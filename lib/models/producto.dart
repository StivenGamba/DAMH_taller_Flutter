class Producto {
  final int productId;
  final String stringNombre;
  final String? stringDescripcion;
  final double decimalPrecio;
  final int intStock;
  final String? stringCategoria;
  final String? stringImagenUrl;
  final String? stringSku;
  final bool booleanDisponible;
  final DateTime? fechaCreacion;

  Producto({
    required this.productId,
    required this.stringNombre,
    this.stringDescripcion,
    required this.decimalPrecio,
    required this.intStock,
    this.stringCategoria,
    this.stringImagenUrl,
    this.stringSku,
    this.booleanDisponible = true,
    this.fechaCreacion,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      productId: json['product_id'],
      stringNombre: json['string_nombre'] ?? '',
      stringDescripcion: json['string_descripcion'],
      decimalPrecio: (json['decimal_precio'] ?? 0.0).toDouble(),
      intStock: json['int_stock'] ?? 0,
      stringCategoria: json['string_categoria'],
      stringImagenUrl: json['string_imagen_url'],
      stringSku: json['string_sku'],
      booleanDisponible: json['boolean_disponible'] ?? true,
      fechaCreacion:
          json['fecha_creacion'] != null
              ? DateTime.parse(json['fecha_creacion'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'string_nombre': stringNombre,
      'string_descripcion': stringDescripcion,
      'decimal_precio': decimalPrecio,
      'int_stock': intStock,
      'string_categoria': stringCategoria,
      'string_imagen_url': stringImagenUrl,
      'string_sku': stringSku,
      'boolean_disponible': booleanDisponible,
      'fecha_creacion': fechaCreacion?.toIso8601String(),
    };
  }
}
