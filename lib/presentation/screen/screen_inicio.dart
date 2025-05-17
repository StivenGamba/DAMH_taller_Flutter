import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class InicioScreen extends StatefulWidget {
  final GoogleSignInAccount? user;

  const InicioScreen({Key? key, required this.user}) : super(key: key);

  @override
  _InicioScreenState createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pantalla de Inicio')),
      body: const Center(child: Text('¡Bienvenido a la pantalla de inicio!')),
    );
  }
}
