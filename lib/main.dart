import 'package:flutter/material.dart';
import 'package:project_filtro/Login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 196, 0)),
        useMaterial3: true,
      ),
      home: const AutenticacaoTela(),
    );
  }
}
