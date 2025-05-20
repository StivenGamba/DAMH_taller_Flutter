import 'package:flutter/material.dart';
import '../../core/color.dart';
import '../../core/string.dart';
import '../../core/routes.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Lista de items en el carrito (ejemplo)
  List<Map<String, dynamic>> _cartItems = [
    {
      'id': 1,
      'nombre': 'Camiseta Barcelona Local',
      'precio': 120000,
      'imagen': 'assets/products/barcelona.jpg',
      'talla': 'M',
      'color': 'Azul/Rojo',
      'cantidad': 1,
    },
    {
      'id': 3,
      'nombre': 'Camiseta Bayern Munich',
      'precio': 110000,
      'imagen': 'assets/products/bayern.jpg',
      'talla': 'L',
      'color': 'Rojo',
      'cantidad': 2,
    },
  ];

  // Código de descuento
  String _codigoDescuento = '';
  bool _descuentoAplicado = false;
  double _porcentajeDescuento = 0;

  // Calcular subtotal
  double get _subtotal {
    return _cartItems.fold(
      0,
      (total, item) => total + (item['precio'] * item['cantidad']),
    );
  }

  // Calcular descuento
  double get _descuento {
    return _descuentoAplicado ? _subtotal * _porcentajeDescuento : 0;
  }

  // Calcular impuestos (IVA 19%)
  double get _impuestos {
    return (_subtotal - _descuento) * 0.19;
  }

  // Calcular total
  double get _total {
    return _subtotal - _descuento + _impuestos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
        backgroundColor: AppColors.azulOscuro,
        actions: [
          if (_cartItems.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _mostrarDialogoVaciarCarrito();
              },
            ),
        ],
      ),
      body: _cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      bottomNavigationBar: _cartItems.isEmpty ? null : _buildBottomBar(),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Tu carrito está vacío',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Agrega camisetas de tus equipos favoritos',
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

  Widget _buildCartContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Lista de productos
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              return _buildCartItem(_cartItems[index], index);
            },
          ),

          // Sección de código de descuento
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Código de Descuento',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Ingresa tu código',
                          border: OutlineInputBorder(),
                          enabled: !_descuentoAplicado,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _codigoDescuento = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed:
                          _descuentoAplicado
                              ? null
                              : () {
                                // Simulación de aplicación de código de descuento
                                if (_codigoDescuento.toUpperCase() ==
                                    'CAMISETA20') {
                                  setState(() {
                                    _descuentoAplicado = true;
                                    _porcentajeDescuento =
                                        0.2; // 20% de descuento
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Descuento del 20% aplicado',
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Código de descuento inválido',
                                      ),
                                    ),
                                  );
                                }
                              },
                      child: Text(_descuentoAplicado ? 'Aplicado' : 'Aplicar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _descuentoAplicado
                                ? Colors.green
                                : AppColors.azulOscuro,
                      ),
                    ),
                  ],
                ),
                if (_descuentoAplicado)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Descuento del ${(_porcentajeDescuento * 100).toInt()}% aplicado',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _descuentoAplicado = false;
                              _porcentajeDescuento = 0;
                              _codigoDescuento = '';
                            });
                          },
                          child: Text(
                            'Quitar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Resumen de la compra
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumen de Compra',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 16),
                _buildResumenRow('Subtotal', '\$${_subtotal.toInt()}'),
                if (_descuentoAplicado)
                  _buildResumenRow(
                    'Descuento (${(_porcentajeDescuento * 100).toInt()}%)',
                    '-\$${_descuento.toInt()}',
                    isDiscount: true,
                  ),
                _buildResumenRow('IVA (19%)', '\$${_impuestos.toInt()}'),
                Divider(height: 32),
                _buildResumenRow('Total', '\$${_total.toInt()}', isBold: true),
              ],
            ),
          ),

          SizedBox(height: 100), // Espacio para el bottomNavigationBar
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Dismissible(
      key: Key(item['id'].toString()),
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
                title: Text('Quitar del Carrito'),
                content: Text('¿Quieres quitar esta camiseta de tu carrito?'),
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
        setState(() {
          _cartItems.removeAt(index);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item['nombre']} quitado del carrito'),
            action: SnackBarAction(
              label: 'Deshacer',
              onPressed: () {
                setState(() {
                  _cartItems.insert(index, item);
                });
              },
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.grisClaro,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  'assets/icons/logoEstrellas.png',
                  width: 70,
                  height: 70,
                ),
              ),
              SizedBox(width: 16),
              // Detalles del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['nombre'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$${item['precio']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulOscuro,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Talla: ${item['talla']} | Color: ${item['color']}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    // Control de cantidad
                    Row(
                      children: [
                        _buildQuantityButton(Icons.remove, () {
                          if (item['cantidad'] > 1) {
                            setState(() {
                              item['cantidad']--;
                            });
                          }
                        }),
                        Container(
                          width: 40,
                          child: Text(
                            '${item['cantidad']}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildQuantityButton(Icons.add, () {
                          setState(() {
                            item['cantidad']++;
                          });
                        }),
                        Spacer(),
                        Text(
                          '\$${(item['precio'] * item['cantidad']).toInt()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grisOsecuro),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget _buildResumenRow(
    String label,
    String value, {
    bool isBold = false,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 16,
              color: isDiscount ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total', style: TextStyle(fontSize: 14)),
                  Text(
                    '\$${_total.toInt()}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.azulOscuro,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _procederAlPago();
                },
                child: Text('Proceder al Pago'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.azulOscuro,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoVaciarCarrito() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Vaciar Carrito'),
            content: Text(
              '¿Estás seguro de que quieres vaciar tu carrito de compras?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _cartItems = [];
                    _descuentoAplicado = false;
                    _porcentajeDescuento = 0;
                    _codigoDescuento = '';
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Vaciar Carrito',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void _procederAlPago() {
    // Aquí puedes navegar a la pantalla de pago
    // Por ahora solo mostraremos un diálogo de confirmación
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Confirmar Pedido'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total a pagar: \$${_total.toInt()}'),
                SizedBox(height: 16),
                Text('¿Deseas confirmar tu pedido?'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  // Simular procesamiento de pedido
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Row(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 16),
                            Text("Procesando tu pedido..."),
                          ],
                        ),
                      );
                    },
                  );

                  // Simular un proceso que toma tiempo
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pop(
                      context,
                    ); // Cierra el diálogo de procesamiento

                    // Mostrar confirmación de pedido exitoso
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text("¡Pedido Realizado!"),
                            ],
                          ),
                          content: Text(
                            "Tu pedido ha sido procesado con éxito. " +
                                "Recibirás un correo con los detalles de tu compra.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Limpiar carrito
                                setState(() {
                                  _cartItems = [];
                                  _descuentoAplicado = false;
                                  _porcentajeDescuento = 0;
                                  _codigoDescuento = '';
                                });
                                // Navegar a la pantalla de inicio
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed(Routes.inicio);
                              },
                              child: Text("Aceptar"),
                            ),
                          ],
                        );
                      },
                    );
                  });
                },
                child: Text('Confirmar', style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
    );
  }
}
