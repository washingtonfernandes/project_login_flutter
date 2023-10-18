import 'package:flutter/material.dart';
import 'package:project_filtro/comum/cores.dart';
import 'package:project_filtro/pages/login/login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [MinhasCores.amarelo, MinhasCores.amareloBaixo],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            //Inserir validação - Form
            child: Form(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      //imagem
                      children: [
                        Image.asset(
                          "assets/images/vofaze3.png",
                          height: 120,
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AutenticacaoTela()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.yellow,
                          ),
                          child: Text(
                            "Hotel HSP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
