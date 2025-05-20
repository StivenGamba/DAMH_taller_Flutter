import 'package:flutter/material.dart';
import '../../core/color.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Lista de categorías principales
  final List<Map<String, dynamic>> _categorias = [
    {
      'nombre': 'La Liga',
      'imagen': 'assets/icons/laliga.png',
      'subcategorias': [
        'Barcelona',
        'Real Madrid',
        'Atlético de Madrid',
        'Valencia',
        'Sevilla',
      ],
    },
    {
      'nombre': 'Premier League',
      'imagen': 'assets/icons/premier.png',
      'subcategorias': [
        'Manchester United',
        'Liverpool',
        'Chelsea',
        'Arsenal',
        'Manchester City',
      ],
    },
    {
      'nombre': 'Serie A',
      'imagen': 'assets/icons/seriea.png',
      'subcategorias': ['Juventus', 'Inter', 'Milan', 'Roma', 'Napoli'],
    },
    {
      'nombre': 'Bundesliga',
      'imagen': 'assets/icons/bundesliga.png',
      'subcategorias': [
        'Bayern Munich',
        'Borussia Dortmund',
        'RB Leipzig',
        'Bayer Leverkusen',
      ],
    },
    {
      'nombre': 'Ligue 1',
      'imagen': 'assets/icons/ligue1.png',
      'subcategorias': ['PSG', 'Lyon', 'Marseille', 'Monaco'],
    },
    {
      'nombre': 'Selecciones',
      'imagen': 'assets/icons/world.png',
      'subcategorias': [
        'Colombia',
        'Argentina',
        'Brasil',
        'España',
        'Francia',
        'Alemania',
      ],
    },
    {
      'nombre': 'Ofertas',
      'imagen': 'assets/icons/ofertas.png',
      'subcategorias': ['Descuentos', 'Promociones 2x1', '50% OFF'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías'),
        backgroundColor: AppColors.azulOscuro,
      ),
      body: ListView.builder(
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          return _buildCategoryCard(_categorias[index]);
        },
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> categoria) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.azulClaro.withOpacity(0.3),
          child: Image.asset(
            'assets/icons/logoEstrellas.png', // Usa un placeholder, reemplaza con categoria['imagen'] cuando tengas las imágenes
            width: 24,
            height: 24,
          ),
        ),
        title: Text(
          categoria['nombre'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                ...categoria['subcategorias'].map<Widget>((subcat) {
                  return ListTile(
                    title: Text(subcat),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navegar a productos de esta subcategoría
                      _navigateToSubcategory(categoria['nombre'], subcat);
                    },
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSubcategory(String categoria, String subcategoria) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Mostrando camisetas de $subcategoria en $categoria"),
        duration: Duration(seconds: 1),
      ),
    );

    // Aquí irá la navegación a la pantalla de productos filtrados
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ProductListScreen(
    //       categoria: categoria,
    //       subcategoria: subcategoria,
    //     ),
    //   ),
    // );
  }
}
