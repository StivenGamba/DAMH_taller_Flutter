import 'package:flutter/material.dart';
import '../../core/color.dart';
import '../../core/string.dart';
import '../../core/routes.dart';
import 'package:provider/provider.dart';
import '../../services/favorite_service.dart';
import '../../services/auth_service.dart';
import '../../data/models/user_model.dart';

class InicioScreen extends StatefulWidget {
  final User? currentUser;

  const InicioScreen({super.key, this.currentUser});

  @override
  _InicioScreenState createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _camisetas = [
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

  final List<String> _categorias = [
    'Todos',
    'La Liga',
    'Premier League',
    'Serie A',
    'Bundesliga',
    'Ofertas',
  ];

  String _categoriaSeleccionada = 'Todos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camiseta Futbolera'),
        backgroundColor: AppColors.azulOscuro,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Acción para buscar
              showSearch(
                context: context,
                delegate: _CamisetaSearchDelegate(_camisetas),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navegar al carrito
              Navigator.pushNamed(context, Routes.cart);
            },
          ),
        ],
      ),
      drawer: Drawer(child: _buildDrawer()),
      body: Column(
        children: [
          // Bienvenida personalizada si hay usuario
          if (widget.currentUser != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  if (widget.currentUser?.photoUrl != null)
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.currentUser!.photoUrl!,
                      ),
                      radius: 20,
                    )
                  else
                    CircleAvatar(
                      child: Text(
                        widget.currentUser?.name?.substring(0, 1) ?? 'U',
                      ),
                      radius: 20,
                    ),
                  SizedBox(width: 10),
                  Text(
                    '¡Bienvenido, ${widget.currentUser?.name ?? 'Usuario'}!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

          // Categorías horizontales
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categorias.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(_categorias[index]),
                    selected: _categoriaSeleccionada == _categorias[index],
                    onSelected: (selected) {
                      setState(() {
                        _categoriaSeleccionada = _categorias[index];
                      });
                    },
                    backgroundColor: AppColors.grisClaro,
                    selectedColor: AppColors.azulClaro,
                  ),
                );
              },
            ),
          ),

          // Banner promocional
          Container(
            height: 150,
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.azulClaro.withOpacity(0.3),
              image: DecorationImage(
                image: AssetImage('assets/icons/logoEstrellas.png'),
                alignment: Alignment.centerRight,
                scale: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '20% DE DESCUENTO',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.azulOscuro,
                    ),
                  ),
                  Text(
                    'En todas las camisetas de La Liga',
                    style: TextStyle(fontSize: 16, color: AppColors.negro),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navegar a ofertas o filtrar por ofertas
                      setState(() {
                        _categoriaSeleccionada = 'Ofertas';
                      });
                    },
                    child: Text('Ver Ofertas'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.azulOscuro,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Título del catálogo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Catálogo de Camisetas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    // Navegar a ver todas las camisetas o categorías
                    Navigator.pushNamed(context, Routes.categories);
                  },
                  child: Text(
                    'Ver todos',
                    style: TextStyle(color: AppColors.azulClaro),
                  ),
                ),
              ],
            ),
          ),

          // Catálogo de camisetas
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _camisetas.length,
              itemBuilder: (context, index) {
                return _buildCamisetaCard(_camisetas[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.azulOscuro,
        unselectedItemColor: AppColors.grisOsecuro,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Navegar según el índice seleccionado
          switch (index) {
            case 0: // Inicio - estamos en Inicio, no hace falta navegar
              break;
            case 1: // Categorías
              Navigator.pushNamed(context, Routes.categories);
              break;
            case 2: // Favoritos
              Navigator.pushNamed(context, Routes.favorites);
              break;
            case 3: // Perfil
              Navigator.pushNamed(
                context,
                Routes.profile,
                arguments: widget.currentUser,
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(widget.currentUser?.name ?? 'Usuario'),
          accountEmail: Text(widget.currentUser?.email ?? 'email@ejemplo.com'),
          currentAccountPicture: CircleAvatar(
            backgroundImage:
                widget.currentUser?.photoUrl != null
                    ? NetworkImage(widget.currentUser!.photoUrl!)
                    : null,
            child:
                widget.currentUser?.photoUrl == null
                    ? Text(
                      widget.currentUser?.name?.substring(0, 1) ?? 'U',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    )
                    : null,
          ),
        ),
        DrawerHeader(
          decoration: BoxDecoration(color: AppColors.azulOscuro),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/logoEstrellas.png',
                width: 60,
                height: 60,
              ),
              SizedBox(height: 10),
              Text(
                'Camiseta Futbolera',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              if (widget.currentUser != null)
                Text(
                  widget.currentUser!.email,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Inicio'),
          onTap: () {
            Navigator.pop(context); // Cerrar drawer
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.category),
          title: Text('Categorías'),
          onTap: () {
            Navigator.pop(context); // Cerrar drawer
            Navigator.pushNamed(context, Routes.categories);
          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Carrito'),
          onTap: () {
            Navigator.pop(context); // Cerrar drawer
            Navigator.pushNamed(context, Routes.cart);
          },
        ),
        ListTile(
          leading: Icon(Icons.history),
          title: Text('Mis Pedidos'),
          onTap: () {
            Navigator.pop(context); // Cerrar drawer
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Historial de pedidos - Próximamente")),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Favoritos'),
          onTap: () {
            Navigator.pop(context); // Cerrar drawer
            Navigator.pushNamed(context, Routes.favorites);
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Perfil'),
          onTap: () {
            Navigator.pop(context); // Cerrar drawer
            Navigator.pushNamed(
              context,
              Routes.profile,
              arguments: widget.currentUser,
            );
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.help),
          title: Text('Ayuda'),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Centro de ayuda - Próximamente")),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Cerrar Sesión'),
          onTap: () {
            Navigator.pop(context);
            // Mostrar diálogo de confirmación
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: Text('Cerrar Sesión'),
                    content: Text(
                      '¿Estás seguro de que quieres cerrar sesión?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(Routes.login);
                        },
                        child: Text(
                          'Cerrar Sesión',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCamisetaCard(Map<String, dynamic> camiseta) {
    // Acceder al servicio de favoritos
    final favoriteService = Provider.of<FavoriteService>(
      context,
      listen: false,
    );
    final isFavorite = favoriteService.isFavorite(camiseta['id']);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Navegar a detalles de la camiseta
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Detalles de ${camiseta['nombre']} - Próximamente"),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grisClaro,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icons/logoEstrellas.png', // Utilizamos la imagen disponible como placeholder
                    fit: BoxFit.contain,
                    height: 100,
                  ),
                ),
              ),
            ),
            // Información del producto
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    camiseta['nombre'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '\$${camiseta['precio']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.azulOscuro,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('Tallas: '),
                          Text(
                            camiseta['tallas'].join(', '),
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          // Togglear favorito
                          favoriteService.toggleFavorite(camiseta['id']);

                          // Mostrar mensaje
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFavorite
                                    ? "Eliminado de favoritos"
                                    : "Añadido a favoritos",
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          );

                          // Forzar reconstrucción del widget para mostrar cambio
                          setState(() {});
                        },
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Delegado para búsqueda de camisetas
class _CamisetaSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> camisetas;

  _CamisetaSearchDelegate(this.camisetas);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results =
        camisetas
            .where(
              (camiseta) => camiseta['nombre'].toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final camiseta = results[index];
        return ListTile(
          title: Text(camiseta['nombre']),
          subtitle: Text('\$${camiseta['precio']}'),
          leading: CircleAvatar(child: Text(camiseta['nombre'][0])),
          onTap: () {
            // Navegar a detalles
            close(context, camiseta['id'].toString());
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results =
        camisetas
            .where(
              (camiseta) => camiseta['nombre'].toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final camiseta = results[index];
        return ListTile(
          title: Text(camiseta['nombre']),
          subtitle: Text('\$${camiseta['precio']}'),
          leading: CircleAvatar(child: Text(camiseta['nombre'][0])),
          onTap: () {
            query = camiseta['nombre'];
            showResults(context);
          },
        );
      },
    );
  }
}
