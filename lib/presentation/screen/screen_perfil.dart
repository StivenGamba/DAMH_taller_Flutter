import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../data/models/user_model.dart';
import '../../core/routes.dart';
import '../../core/color.dart';
import '../../core/string.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.currentUser}) : super(key: key);

  final User? currentUser;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificacionesActivas = true;
  bool _ofertasEmail = true;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final currentUser = widget.currentUser ?? authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: AppColors.azulOscuro,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navegar a editar perfil
              Navigator.pushNamed(
                context,
                Routes.editProfile,
                arguments: currentUser,
              );
            },
          ),
        ],
      ),
      body:
          currentUser == null
              ? const Center(
                child: Text('Debes iniciar sesión para ver tu perfil'),
              )
              : SingleChildScrollView(
                child: Column(
                  children: [
                    // Sección de cabecera con info del usuario
                    _buildProfileHeader(currentUser),

                    const Divider(),

                    // Sección de opciones de cuenta
                    _buildAccountOptions(),

                    const Divider(),

                    // Sección de preferencias
                    _buildPreferences(),

                    const Divider(),

                    // Sección de ayuda y soporte
                    _buildHelpSupport(),

                    // Botón de cerrar sesión
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _confirmLogout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Cerrar Sesión'),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Versión de la aplicación: 1.0.0',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
    );
  }

  Widget _buildProfileHeader(User? currentUser) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Avatar del usuario
          if (currentUser?.photoUrl != null &&
              currentUser!.photoUrl!.isNotEmpty)
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(currentUser.photoUrl!),
              backgroundColor: AppColors.azulClaro,
            )
          else
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.azulClaro,
              child: Text(
                currentUser?.name?.isNotEmpty == true
                    ? currentUser!.name!.substring(0, 1).toUpperCase()
                    : 'U',
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),

          const SizedBox(height: 16),

          // Nombre del usuario
          Text(
            currentUser?.name ?? 'Usuario',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // Email del usuario
          Text(
            currentUser?.email ?? 'email@ejemplo.com',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),

          const SizedBox(height: 16),

          // Stats del usuario
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn('3', 'Pedidos'),
              _buildStatColumn('5', 'Camisetas'),
              _buildStatColumn('2', 'Equipos'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildAccountOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'CUENTA',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),

        _buildOptionTile(
          icon: Icons.person,
          title: 'Información Personal',
          onTap: () {
            // Navegar a información personal
          },
        ),

        _buildOptionTile(
          icon: Icons.location_on,
          title: 'Mis Direcciones',
          onTap: () {
            // Navegar a direcciones
          },
        ),

        _buildOptionTile(
          icon: Icons.payment,
          title: 'Métodos de Pago',
          onTap: () {
            // Navegar a métodos de pago
          },
        ),

        _buildOptionTile(
          icon: Icons.history,
          title: 'Historial de Pedidos',
          onTap: () {
            // Navegar a historial de pedidos
          },
        ),
      ],
    );
  }

  Widget _buildPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'PREFERENCIAS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),

        SwitchListTile(
          title: const Text('Notificaciones'),
          subtitle: const Text('Recibir notificaciones de la aplicación'),
          value: _notificacionesActivas,
          activeColor: AppColors.azulOscuro,
          onChanged: (value) {
            setState(() {
              _notificacionesActivas = value;
            });
          },
        ),

        SwitchListTile(
          title: const Text('Ofertas por Email'),
          subtitle: const Text('Recibir correos con promociones'),
          value: _ofertasEmail,
          activeColor: AppColors.azulOscuro,
          onChanged: (value) {
            setState(() {
              _ofertasEmail = value;
            });
          },
        ),

        _buildOptionTile(
          icon: Icons.language,
          title: 'Idioma',
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Español'),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
          onTap: () {
            _showLanguageSelector();
          },
        ),
      ],
    );
  }

  Widget _buildHelpSupport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'AYUDA Y SOPORTE',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),

        _buildOptionTile(
          icon: Icons.help_outline,
          title: 'Centro de Ayuda',
          onTap: () {
            _showHelpCenter();
          },
        ),

        _buildOptionTile(
          icon: Icons.description,
          title: 'Términos y Condiciones',
          onTap: () {
            Navigator.pushNamed(context, Routes.terms);
          },
        ),

        _buildOptionTile(
          icon: Icons.privacy_tip,
          title: 'Política de Privacidad',
          onTap: () {
            _showPrivacyPolicy();
          },
        ),
      ],
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.azulOscuro),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _confirmLogout() {
    final authService = Provider.of<AuthService>(context, listen: false);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cerrar Sesión'),
            content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await authService.logout();
                    if (mounted) {
                      Navigator.pop(context); // Cierra el diálogo
                      Navigator.pushReplacementNamed(context, Routes.login);
                    }
                  } catch (e) {
                    if (mounted) {
                      Navigator.pop(context); // Cierra el diálogo
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al cerrar sesión: $e')),
                      );
                    }
                  }
                },
                child: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text(
                  'Selecciona un idioma',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: const Text('Español'),
                leading: const Icon(Icons.check, color: AppColors.azulOscuro),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Inglés'),
                onTap: () {
                  Navigator.pop(context);
                  // Cambiar a inglés
                },
              ),
              ListTile(
                title: const Text('Portugués'),
                onTap: () {
                  Navigator.pop(context);
                  // Cambiar a portugués
                },
              ),
            ],
          ),
    );
  }

  void _showHelpCenter() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Centro de Ayuda'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Preguntas Frecuentes',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text('• ¿Cómo realizo un pedido?'),
                  Text('• ¿Cuáles son los métodos de pago disponibles?'),
                  Text('• ¿Cómo puedo hacer seguimiento a mi pedido?'),
                  Text('• ¿Cuál es la política de devoluciones?'),
                  SizedBox(height: 16),
                  Text(
                    'Contacto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text('Email: soporte@camisetafutbolera.com'),
                  Text('Teléfono: +57 300 123 4567'),
                  Text('Horario: Lunes a Viernes 8:00 AM - 6:00 PM'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Implementar función para chatear con soporte
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Función de chat con soporte - Próximamente',
                      ),
                    ),
                  );
                },
                child: const Text('Chatear con Soporte'),
              ),
            ],
          ),
    );
  }

  void _showPrivacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Política de Privacidad'),
                backgroundColor: AppColors.azulOscuro,
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Política de Privacidad',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Última actualización: 19 de mayo, 2025',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      '1. Información que Recopilamos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'En Camiseta Futbolera recopilamos información personal como nombre, correo electrónico, dirección de envío y métodos de pago para poder procesar tus pedidos y brindarte una mejor experiencia de compra.',
                    ),
                    SizedBox(height: 16),
                    Text(
                      '2. Uso de la Información',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Utilizamos tu información para procesar pedidos, personalizar tu experiencia, mejorar nuestro servicio, enviar comunicaciones promocionales (si lo has autorizado) y cumplir con obligaciones legales.',
                    ),
                    SizedBox(height: 16),
                    Text(
                      '3. Protección de Datos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Implementamos medidas de seguridad para proteger tu información personal contra acceso, alteración, divulgación o destrucción no autorizada.',
                    ),
                    // Añadir más secciones según sea necesario
                  ],
                ),
              ),
            ),
      ),
    );
  }
}

// Clase para personalizar la transición entre pantallas (opcional)
class CustomPageRoute extends PageRouteBuilder {
  final Widget child;

  CustomPageRoute({required this.child})
    : super(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      );
}
