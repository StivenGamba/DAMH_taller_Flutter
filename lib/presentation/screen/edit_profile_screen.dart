import 'package:camiseta_futbolera/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/color.dart';
import '../../core/string.dart';
import '../../core/routes.dart';

class EditProfileScreen extends StatefulWidget {
  final GoogleSignInAccount? user;

  const EditProfileScreen({Key? key, this.user, User? currentUser})
    : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controladores para los campos de texto
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  // Opción de género seleccionada
  String _selectedGender = 'Masculino';

  // Fecha de nacimiento
  DateTime _dateOfBirth = DateTime(1990, 1, 1);

  @override
  void initState() {
    super.initState();

    // Inicializar controladores con datos de usuario si existen
    _nameController = TextEditingController(
      text: widget.user?.displayName ?? 'Usuario',
    );
    _emailController = TextEditingController(
      text: widget.user?.email ?? 'usuario@ejemplo.com',
    );
    _phoneController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // Limpiar controladores
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: AppColors.azulOscuro,
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: Text(
              'Guardar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección de avatar
              Center(
                child: Column(
                  children: [
                    // Avatar existente o predeterminado
                    GestureDetector(
                      onTap: () {
                        // Aquí se podría abrir un selector de imagen
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Cambiar avatar - Próximamente'),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.azulClaro,
                            backgroundImage:
                                widget.user?.photoUrl != null
                                    ? NetworkImage(widget.user!.photoUrl!)
                                    : null,
                            child:
                                widget.user?.photoUrl == null
                                    ? Text(
                                      _nameController.text.isNotEmpty
                                          ? _nameController.text[0]
                                              .toUpperCase()
                                          : 'U',
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                      ),
                                    )
                                    : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.azulOscuro,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Cambiar foto de perfil',
                      style: TextStyle(color: AppColors.azulOscuro),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32),

              // Sección de información personal
              Text(
                'INFORMACIÓN PERSONAL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 16),

              // Campo de nombre
              buildTextField(
                label: 'Nombre Completo',
                controller: _nameController,
                icon: Icons.person,
              ),

              SizedBox(height: 16),

              // Campo de email
              buildTextField(
                label: 'Correo Electrónico',
                controller: _emailController,
                icon: Icons.email,
                enabled: false, // El email normalmente no se permite cambiar
              ),

              SizedBox(height: 16),

              // Campo de teléfono
              buildTextField(
                label: 'Número de Teléfono',
                controller: _phoneController,
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 24),

              // Selección de género
              Text(
                'Género',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              Row(
                children: [
                  Radio<String>(
                    value: 'Masculino',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    activeColor: AppColors.azulOscuro,
                  ),
                  Text('Masculino'),

                  SizedBox(width: 16),

                  Radio<String>(
                    value: 'Femenino',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    activeColor: AppColors.azulOscuro,
                  ),
                  Text('Femenino'),

                  SizedBox(width: 16),

                  Radio<String>(
                    value: 'Otro',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    activeColor: AppColors.azulOscuro,
                  ),
                  Text('Otro'),
                ],
              ),

              SizedBox(height: 24),

              // Fecha de nacimiento
              Text(
                'Fecha de Nacimiento',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8),

              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: AppColors.azulOscuro),
                      SizedBox(width: 12),
                      Text(
                        '${_dateOfBirth.day}/${_dateOfBirth.month}/${_dateOfBirth.year}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 32),

              // Sección de dirección
              Text(
                'DIRECCIÓN DE ENVÍO',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 16),

              OutlinedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Agregar dirección de envío'),
                onPressed: () {
                  // Navegar a la pantalla de agregar dirección
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Agregar dirección - Próximamente')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),

              SizedBox(height: 32),

              // Sección de contraseña
              Text(
                'SEGURIDAD',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 16),

              ListTile(
                leading: Icon(Icons.lock, color: AppColors.azulOscuro),
                title: Text('Cambiar Contraseña'),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navegar a la pantalla de cambio de contraseña
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Cambiar contraseña - Próximamente'),
                    ),
                  );
                },
              ),

              SizedBox(height: 40),

              // Botón para guardar cambios
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Guardar Cambios'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para construir campos de texto consistentes
  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.azulOscuro),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.azulOscuro, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: !enabled,
        fillColor: enabled ? null : Colors.grey.shade100,
      ),
    );
  }

  // Método para seleccionar fecha de nacimiento
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.azulOscuro),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _dateOfBirth) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  // Método para guardar cambios
  void _saveChanges() {
    // Aquí se implementaría la lógica para guardar los cambios
    // Por ahora solo mostraremos un mensaje

    // Mostrar un indicador de carga
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Guardando cambios...')));

    // Simular un proceso que toma tiempo
    Future.delayed(Duration(seconds: 1), () {
      // Navegar de regreso con los datos actualizados
      Navigator.pop(context);

      // Mostrar confirmación en la pantalla anterior
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Perfil actualizado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }
}
