import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/color.dart';
import '../../services/favorite_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Lista de todas las camisetas disponibles (para obtener los datos completos)
  final List<Map<String, dynamic>> _todasLasCamisetas = [
    {
      'id': 1,
      'nombre': 'Camiseta Barcelona Local',
      'precio': 120000,
      'imagen': 'assets/products/barcelona.jpg',
      'tallas': ['S', 'M', 'L', 'XL'],
      'colores': ['Azul', 'Rojo'],
    },
    {
      'id': 2,
      'nombre': 'Camiseta Real Madrid Visitante',
      'precio': 115000,
      'imagen': 'assets/products/real_madrid.jpg',
      'tallas': ['S', 'M', 'L', 'XL'],
      'colores': ['Blanco', 'Negro'],
    },
    {
      'id': 3,
      'nombre': 'Camiseta Bayern Munich',
      'precio': 110000,
      'imagen': 'assets/products/bayern.jpg',
      'tallas': ['S', 'M', 'L', 'XL'],
      'colores': ['Rojo', 'Azul'],
    },
    {
      'id': 4,
      'nombre': 'Camiseta Liverpool FC',
      'precio': 105000,
      'imagen': 'assets/products/liverpool.jpg',
      'tallas': ['S', 'M', 'L', 'XL'],
      'colores': ['Rojo'],
    },
    {
      'id': 5,
      'nombre': 'Camiseta Manchester City',
      'precio': 118000,
      'imagen': 'assets/products/city.jpg',
      'tallas': ['S', 'M', 'L', 'XL'],
      'colores': ['Azul Claro'],
    },
    {
      'id': 6,
      'nombre': 'Camiseta Juventus',
      'precio': 112000,
      'imagen': 'assets/products/juventus.jpg',
      'tallas': ['S', 'M', 'L', 'XL'],
      'colores': ['Blanco', 'Negro'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Obtener el servicio de favoritos
    final favoriteService = Provider.of<FavoriteService>(context);

    // Obtener los IDs de favoritos
    final List<int> favoritesIds = favoriteService.favoritesIds;

    // Filtrar las camisetas para mostrar solo los favoritos
    final List<Map<String, dynamic>> _favoritos =
        _todasLasCamisetas
            .where((camiseta) => favoritesIds.contains(camiseta['id']))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Favoritos'),
        backgroundColor: AppColors.azulOscuro,
        actions: [
          if (_favoritos.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () {
                _mostrarDialogoLimpiarFavoritos(favoriteService);
              },
            ),
        ],
      ),
      body:
          _favoritos.isEmpty
              ? _buildEmptyFavorites()
              : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: _favoritos.length,
                itemBuilder: (context, index) {
                  return _buildFavoriteItem(_favoritos[index], favoriteService);
                },
              ),
    );
  }

  Widget _buildEmptyFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No tienes camisetas favoritas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Añade camisetas a tus favoritos para verlas aquí',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navegar al catálogo
              Navigator.pop(context);
            },
            child: Text('Explorar Catálogo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.azulOscuro,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(
    Map<String, dynamic> camiseta,
    FavoriteService favoriteService,
  ) {
    return Dismissible(
      key: Key(camiseta['id'].toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Quitar de Favoritos'),
                content: Text(
                  '¿Quieres quitar esta camiseta de tus favoritos?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Quitar', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
        );
      },
      onDismissed: (direction) {
        // Quitar de favoritos usando el servicio
        favoriteService.toggleFavorite(camiseta['id']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camiseta quitada de favoritos'),
            action: SnackBarAction(
              label: 'Deshacer',
              onPressed: () {
                favoriteService.toggleFavorite(camiseta['id']);
              },
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            // Navegar a detalles del producto
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen del producto
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.grisClaro,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/logoEstrellas.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                // Información del producto
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        camiseta['nombre'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '\$${camiseta['precio']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.azulOscuro,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tallas: ${camiseta['tallas'].join(', ')}',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton.icon(
                            icon: Icon(Icons.shopping_cart),
                            label: Text('Añadir'),
                            onPressed: () {
                              // Añadir al carrito
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Añadido al carrito')),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              // Quitar de favoritos usando el servicio
                              favoriteService.toggleFavorite(camiseta['id']);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Quitado de favoritos'),
                                  action: SnackBarAction(
                                    label: 'Deshacer',
                                    onPressed: () {
                                      favoriteService.toggleFavorite(
                                        camiseta['id'],
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoLimpiarFavoritos(FavoriteService favoriteService) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Limpiar Favoritos'),
            content: Text('¿Quieres eliminar todas tus camisetas favoritas?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  // Limpiar todos los favoritos usando el servicio
                  favoriteService.clearAll();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Eliminar Todo',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
