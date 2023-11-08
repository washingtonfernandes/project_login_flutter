import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_vofaze/comum/cores.dart';

class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({super.key});

  @override
  State<RecuperarSenha> createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  Future redefinirSenha() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: MinhasCores.amarelo,
            content: Text(
              "Senha redefinida, verifique seu email!",
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              e.message.toString(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MinhasCores.amarelo,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fundo_app.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                ),
                Image.asset(
                  "assets/images/vofaze3.png",
                  height: 100,
                ),
                SizedBox(
                  height: 12,
                ),
                Text("Entre com o email para resetar a senha!"),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: MinhasCores.amarelo),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      hintText: "Email",
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                    ),
                    validator: (String? value) {
                      if (value == null) {
                        return "O email não pode ser vazio!";
                      }
                      if (value.length < 5) {
                        return "Email não válido!";
                      }
                      if (!value.contains("@")) {
                        return "Email não válido!";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: redefinirSenha,
                  child: Text(
                    "Redefinir Senha",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.yellow,
                    backgroundColor:
                        Colors.black, // Text Color (Foreground color)
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
