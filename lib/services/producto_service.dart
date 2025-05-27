import '../config/supabase_config.dart';
import '../models/producto.dart';

class ProductoService {
  static final _supabase = SupabaseConfig.client;

  static Future<List<Producto>> obtenerProductos() async {
    try {
      final response = await _supabase
          .from('productos')
          .select('*')
          .eq('boolean_disponible', true)
          .order('fecha_creacion', ascending: false);

      return (response as List)
          .map((producto) => Producto.fromJson(producto))
          .toList();
    } catch (error) {
      print('Error al obtener productos: $error');
      return [];
    }
  }

  static Future<List<Producto>> obtenerProductosPorCategoria(
    String categoria,
  ) async {
    try {
      final response = await _supabase
          .from('productos')
          .select('*')
          .eq('string_categoria', categoria)
          .eq('boolean_disponible', true)
          .order('decimal_precio', ascending: false);

      return (response as List)
          .map((producto) => Producto.fromJson(producto))
          .toList();
    } catch (error) {
      print('Error al obtener productos por categoría: $error');
      return [];
    }
  }

  static Future<Producto?> obtenerProductoPorId(int productId) async {
    try {
      final response =
          await _supabase
              .from('productos')
              .select('*')
              .eq('product_id', productId)
              .single();

      return Producto.fromJson(response);
    } catch (error) {
      print('Error al obtener producto: $error');
      return null;
    }
  }
}
