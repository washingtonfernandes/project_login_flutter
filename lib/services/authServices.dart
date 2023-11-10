import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // Importe o Firestore

import 'package:flutter/foundation.dart';


class AutenticacaoServico with ChangeNotifier {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore =

      FirebaseFirestore.instance; // Instância do Firestore

  User? _usuario;


  User? get usuario => _usuario;


  bool isLoading = true;


  AutenticacaoServico() {

    _firebaseAuth.authStateChanges().listen((user) {

      _usuario = user;

      isLoading = false;

      notifyListeners();

    });

  }


  Future<String?> cadastrarUsuario({

    required String nome,

    required String senha,

    required String email,

  }) async {

    try {

      UserCredential userCredential =

          await _firebaseAuth.createUserWithEmailAndPassword(

        email: email,

        password: senha,

      );


      await userCredential.user!.updateDisplayName(nome);


      // Crie um documento igual ao do auth

      await _firestore.collection('users').doc(userCredential.user!.uid).set({

        'nome': nome,

        'email': email,

        'senha': senha,

      });


      return null;

    } on FirebaseAuthException catch (e) {

      if (e.code == "email-already-in-use") {

        return "O usuário já está cadastrado";

      }

      return "Erro desconhecido!";

    }

  }


  Future<String?> logarUsuarios(

      {required String email, required String senha}) async {

    try {

      await _firebaseAuth.signInWithEmailAndPassword(

          email: email, password: senha);

      return null;

    } on FirebaseAuthException catch (e) {

      if (e.code == "INVALID_LOGIN_CREDENTIALS") {

        return "Verifique seu cadastro ou a senha!";

      }

      return "Erro desconhecido!";

    }

  }


  Future<void> deslogar() async {

    return _firebaseAuth.signOut();

  }

}

