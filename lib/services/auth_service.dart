import 'package:google_sign_in/google_sign_in.dart';
import 'package:camiseta_futbolera/domain/entities/user.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  //usuario actual - Datos
  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  //verficacion de autentuificacion de usuario

  Stream<GoogleSignInAccount?> get onCurrentUserChanged =>
      _googleSignIn.onCurrentUserChanged;

  //Iniciar sesion con Google
  Future<GoogleSignInAccount?> singnInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      return googleUser;
    } catch (error) {
      print('Error al iniciar sesion con Google $error');
      return null;
    }
  }

  //cerrar sesion
  Future<void> signOut() => _googleSignIn.signOut();

  //verificar si esta connectado

  Future<bool> isSignesIn() => _googleSignIn.isSignedIn();
}
