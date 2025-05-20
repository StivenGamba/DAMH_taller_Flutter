import 'package:flutter/material.dart';
import '../../core/color.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos y Condiciones'),
        backgroundColor: AppColors.azulOscuro,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TÉRMINOS Y CONDICIONES DE USO',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Última actualización: 19 de Mayo de 2025',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              '1. ACEPTACIÓN DE TÉRMINOS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Al acceder y utilizar la aplicación Camiseta Futbolera, usted acepta cumplir con estos términos y condiciones de uso. Si no está de acuerdo con alguno de estos términos, no debe utilizar nuestra aplicación.',
            ),

            SizedBox(height: 20),
            Text(
              '2. DESCRIPCIÓN DEL SERVICIO',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Camiseta Futbolera es una plataforma para la compra de camisetas de fútbol. Ofrecemos una variedad de camisetas oficiales de diferentes equipos y ligas de todo el mundo.',
            ),

            SizedBox(height: 20),
            Text(
              '3. REGISTRO DE CUENTA',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Para utilizar ciertas funciones de nuestra aplicación, es posible que deba registrarse y crear una cuenta. Usted es responsable de mantener la confidencialidad de la información de su cuenta, incluyendo su contraseña, y de todas las actividades que ocurran bajo su cuenta.',
            ),

            // Continúa con más secciones...
            SizedBox(height: 20),
            Text(
              '4. POLÍTICA DE PRIVACIDAD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Nuestra política de privacidad describe cómo recopilamos, usamos y protegemos la información personal que usted proporciona. Al utilizar nuestra aplicación, usted acepta las prácticas descritas en nuestra política de privacidad.',
            ),

            // Más secciones...
            SizedBox(height: 40),
            Center(
              child: Text(
                'Contacto: soporte@camisetafutbolera.com',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
