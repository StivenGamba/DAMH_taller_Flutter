import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camiseta_futbolera/services/auth_service.dart';
import 'package:camiseta_futbolera/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  final User? user;

  const ProfileScreen({Key? key, this.user, User? currentUser})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final currentUser = authService.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentUser != null)
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    currentUser.photoUrl != null
                        ? NetworkImage(currentUser.photoUrl!)
                        : null,
                child:
                    currentUser.photoUrl == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
              ),
            const SizedBox(height: 20),
            Text(
              currentUser?.name ?? 'Usuario no registrado',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              currentUser?.email ?? '',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authService.logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
