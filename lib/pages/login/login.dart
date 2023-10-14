import 'package:flutter/material.dart';
import 'package:project_filtro/components/decoracao_autenticacao.dart';
import 'package:project_filtro/comum/cores.dart';

class AutenticacaoTela extends StatefulWidget {
  const AutenticacaoTela({super.key});

  @override
  State<AutenticacaoTela> createState() => _AutenticacaoTelaState();
}

class _AutenticacaoTelaState extends State<AutenticacaoTela> {
  //false = cadastrar
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
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
              key: _formKey,
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
                        TextFormField(
                          decoration: getAuthenticationInputDecoration("Email"),
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
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration: getAuthenticationInputDecoration("Senha"),
                          obscureText: true,
                          validator: (String? value) {
                            if (value == null) {
                              return "A senha não pode ser vazio!";
                            }
                            if (value.length < 5) {
                              return "A senha é curta!";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Visibility(
                            visible: !queroEntrar,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: getAuthenticationInputDecoration(
                                      "Confirme a senha"),
                                  obscureText: true,
                                  validator: (String? value) {
                                    if (value == null) {
                                      return "A confirmação de senha não pode ser vazio!";
                                    }
                                    if (value.length < 5) {
                                      return "A senha é curta!";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  decoration:
                                      getAuthenticationInputDecoration("Nome"),
                                  validator: (String? value) {
                                    if (value == null) {
                                      return "O nome não pode ser vazio!";
                                    }
                                    if (value.length < 5) {
                                      return "O nome é curto!";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 36,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            botaoPrincipalClicado();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // Background color
                            onPrimary:
                                Colors.yellow, // Text Color (Foreground color)
                          ),
                          child: Text(
                            //boleano para entrar ou cadastrar
                            (queroEntrar) ? "Entrar" : "Cadastrar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Divider(),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              queroEntrar = !queroEntrar;
                            });
                          },
                          child: Text(
                            //boleano para entrar ou cadastrar
                            (queroEntrar)
                                ? "Ainda não é cadastrado? Cadastre-se!"
                                : "Já temuma conta? Entre!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
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

  botaoPrincipalClicado() {
    if (_formKey.currentState!.validate()) {
      print("Form válido");
    } else {
      print("Form inválido");
    }
  }
}
