import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_filtro/pages/home/home.dart';
import 'package:project_filtro/pages/login/login.dart';
import 'package:project_filtro/pages/splash-screen/splash-screen.dart';

class Vofaze extends StatelessWidget {
  const Vofaze({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 5)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else {
                return const RoteadorTela();
              }
            }));
  }
}

//conexão aberta de informações
class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        } else {
          return const AutenticacaoTela();
        }
      },
    );
  }
}
