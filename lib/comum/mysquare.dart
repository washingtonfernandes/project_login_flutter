import 'package:flutter/material.dart';
import 'package:project_filtro/comum/cores.dart';

class MySquare extends StatelessWidget {
  final String child;

  MySquare({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        color: MinhasCores.amareloBaixo,
        child: Center(
          child: Text(
            child,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
