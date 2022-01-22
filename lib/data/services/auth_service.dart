import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:podfy/data/models/usuario.dart';

class AuthService extends ChangeNotifier {
  Usuario? _usuarioLogado;

  Usuario? get usuarioLogado => this._usuarioLogado;
  set usuarioLogado(Usuario? user) {
    this._usuarioLogado = user;
    notifyListeners();
  }

  entrar(String email, String senha) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
      usuarioLogado = Usuario(userCredential.user?.email ?? '');
      notifyListeners();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<bool> sair() async {
    try {
      await FirebaseAuth.instance.signOut();
      usuarioLogado = null;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
