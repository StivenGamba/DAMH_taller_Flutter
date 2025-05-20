import 'package:flutter/material.dart';
import '../../core/color.dart';
import '../../core/routes.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['nombre'])),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                color: AppColors.grisClaro,
                child:
                    product['imagen'] != null
                        ? Image.asset(
                          product['imagen'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/icons/logoEstrellas.png',
                              fit: BoxFit.contain,
                            );
                          },
                        )
                        : Image.asset(
                          'assets/icons/logoEstrellas.png',
                          fit: BoxFit.contain,
                        ),
              ),
            ),

            // Información del producto
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre y precio
                  Text(
                    product['nombre'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product['precio'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.azulOscuro,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sección de tallas
                  const Text(
                    'Tallas disponibles:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children:
                        (product['tallas'] as List<String>).map((talla) {
                          return Chip(
                            label: Text(talla),
                            backgroundColor: AppColors.grisClaro,
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Sección de colores
                  if (product['colores'] != null &&
                      (product['colores'] as List).isNotEmpty) ...[
                    const Text(
                      'Colores disponibles:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          (product['colores'] as List<String>).map((color) {
                            return Chip(
                              label: Text(color),
                              backgroundColor: AppColors.grisClaro,
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Botón de añadir al carrito
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aquí iría la lógica para añadir al carrito
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Producto añadido al carrito'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'AÑADIR AL CARRITO',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Botón de comprar ahora
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // Aquí iría la lógica para comprar ahora
                        Navigator.pushNamed(context, Routes.cart);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'COMPRAR AHORA',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
