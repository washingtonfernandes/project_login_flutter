import 'package:flutter/material.dart';
import 'package:project_filtro/components/decoracao_autenticacao.dart';
import 'package:project_filtro/comum/snackbar.dart';
import 'package:project_filtro/servicos/authServices.dart';

class AutenticacaoTela extends StatefulWidget {
  const AutenticacaoTela({super.key});

  @override
  State<AutenticacaoTela> createState() => _AutenticacaoTelaState();
}

class _AutenticacaoTelaState extends State<AutenticacaoTela> {
  //false = cadastrar
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();

  AutenticacaoServico _autenticaServico = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fundo_app.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            //Inserir validação - Form
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            "assets/images/vofaze3.png",
                            height: 120,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration:
                                getAuthenticationInputDecoration("Email"),
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
                            height: 32,
                          ),
                          TextFormField(
                            controller: _senhaController,
                            decoration:
                                getAuthenticationInputDecoration("Senha"),
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
                                  SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    controller: _nomeController,
                                    decoration:
                                        getAuthenticationInputDecoration(
                                            "Nome"),
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
                              onPrimary: Colors
                                  .yellow, // Text Color (Foreground color)
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
          ),
        ],
      ),
    );
  }

  botaoPrincipalClicado() {
    String nome = _nomeController.text;
    String senha = _senhaController.text;
    String email = _emailController.text;

    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        print("Entrada validada");
        _autenticaServico
            .logarUsuarios(email: email, senha: senha)
            .then((String? erro) {
          if (erro != null) {
            showSnackbar(context: context, texto: erro);
          }
        });
      } else {
        print("Cadastro validado");
        print(
            "${_emailController.text}, ${_senhaController.text}, ${_nomeController.text}");
        _autenticaServico
            .cadastrarUsuario(
          nome: nome,
          senha: senha,
          email: email,
        )
            .then(
          (String? erro) {
            if (erro != null) {
              //retornou com erro
              showSnackbar(context: context, texto: erro);
            }
          },
        );
      }
    } else {
      print("Form inválido");
    }
  }
}
