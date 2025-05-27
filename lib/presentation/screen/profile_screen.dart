import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camiseta_futbolera/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final currentUser = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(
          0xFF1A5276,
        ), // Color azul oscuro como en la imagen
        title: const Text('Mi Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Acción para editar perfil
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección 1: Información Personal
            ListTile(
              leading: const Icon(Icons.location_on, color: Color(0xFF1A5276)),
              title: const Text('Mis Direcciones'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navegar a la página de direcciones
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.credit_card, color: Color(0xFF1A5276)),
              title: const Text('Métodos de Pago'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navegar a la página de métodos de pago
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.history, color: Color(0xFF1A5276)),
              title: const Text('Historial de Pedidos'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navegar a la página de historial de pedidos
              },
            ),

            // Divisor con espacio y color de fondo gris
            Container(height: 10, color: Colors.grey[200]),

            // Sección 2: Preferencias
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                bottom: 8.0,
              ),
              child: Text(
                'PREFERENCIAS',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            ListTile(
              title: const Text('Notificaciones'),
              subtitle: const Text('Recibir notificaciones de la aplicación'),
              trailing: Switch(
                value: true, // Cambia esto según el estado real
                activeColor: const Color(0xFF1A5276),
                onChanged: (bool value) {
                  // Cambiar preferencia de notificaciones
                },
              ),
            ),

            ListTile(
              title: const Text('Ofertas por Email'),
              subtitle: const Text('Recibir correos con promociones'),
              trailing: Switch(
                value: true, // Cambia esto según el estado real
                activeColor: const Color(0xFF1A5276),
                onChanged: (bool value) {
                  // Cambiar preferencia de email
                },
              ),
            ),

            ListTile(
              leading: const Icon(Icons.language, color: Color(0xFF1A5276)),
              title: const Text('Idioma'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Español',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              onTap: () {
                // Navegar a la página de selección de idioma
              },
            ),

            // Divisor con espacio y color de fondo gris
            Container(height: 10, color: Colors.grey[200]),

            // Sección 3: Ayuda y Soporte
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                top: 16.0,
                bottom: 8.0,
              ),
              child: Text(
                'AYUDA Y SOPORTE',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.help_outline, color: Color(0xFF1A5276)),
              title: const Text('Centro de Ayuda'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navegar a la página de centro de ayuda
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.description, color: Color(0xFF1A5276)),
              title: const Text('Términos y Condiciones'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navegar a la página de términos y condiciones
              },
            ),
            const Divider(height: 1),

            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Color(0xFF1A5276)),
              title: const Text('Política de Privacidad'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navegar a la página de política de privacidad
              },
            ),

            // Botón de cerrar sesión
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF1A5276),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () async {
                    await authService.logout();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: const Text('CERRAR SESIÓN'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
