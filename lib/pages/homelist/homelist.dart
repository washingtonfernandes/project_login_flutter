import 'package:flutter/material.dart';
import 'package:project_filtro/comum/circle.dart';
import 'package:project_filtro/comum/cores.dart';
import 'package:project_filtro/comum/mysquare.dart';

class HomeList extends StatelessWidget {
  final List _posts = [
    "posts 1",
    "posts 2",
    "posts 3",
    "posts 4",
  ];

  final List _stories = [
    "story 1",
    "story 2",
    "story 3",
    "story 4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            color: MinhasCores.amarelo,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            child: ListView.builder(
              itemCount: _posts.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MyCircle(
                  child: _stories[index],
                );
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return MySquare(
                  child: _posts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
