import 'package:flutter/material.dart';
import 'package:project_filtro/pages/searchlist/searchList.dart';
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
                return SearchList();
              }
            }));
  }
}
