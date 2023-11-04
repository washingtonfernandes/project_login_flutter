import 'package:flutter/material.dart';
import 'package:project_filtro/pages/home/home.dart';
import 'package:project_filtro/services/authServices.dart';
import 'package:project_filtro/vofaze.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AutenticacaoServico auth = Provider.of<AutenticacaoServico>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const Vofaze();
    } else {
      return const Home();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
