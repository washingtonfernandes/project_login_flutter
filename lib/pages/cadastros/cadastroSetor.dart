import 'package:flutter/material.dart';
import 'package:project_filtro/comum/cores.dart';

class CadastroSetor extends StatefulWidget {
  const CadastroSetor({Key? key});

  @override
  State<CadastroSetor> createState() => _CadastroSetor();
}

class _CadastroSetor extends State<CadastroSetor> {
  final _formKey = GlobalKey<FormState>();
  List<String> setores = [
    "Setor 1",
    "Setor 2",
    "Setor 3"
  ]; // Exemplo de lista de setores

  TextEditingController setorController = TextEditingController();
  int selectedIndex = -1;

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Image.asset(
                      "assets/images/vofaze3.png",
                      height: 120,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: setorController,
                        decoration: InputDecoration(
                          labelText: "Setor",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                        ),
                        validator: (String? value) {
                          if (value == null) {
                            return "O setor não pode ser vazio!";
                          }
                          if (value.length < 3) {
                            return "Setor não válido!";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            setores.add(setorController.text);
                            setorController.text = '';
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        onPrimary: Colors.yellow,
                      ),
                      child: Text(
                        "Cadastrar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: setores.length,
                        itemBuilder: (context, index) {
                          final setor = setores[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(setor),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.green),
                                    onPressed: () {
                                      showEditDialog(context, setor, index);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      showDeleteConfirmationDialog(
                                          context, index);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showEditDialog(BuildContext context, String setor, int index) {
    TextEditingController editController = TextEditingController(text: setor);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Setor"),
          content: TextFormField(
            controller: editController,
            decoration: InputDecoration(labelText: "Novo Nome do Setor"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  setores[index] = editController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text("Salvar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Setor"),
          content: Text("Você tem certeza que deseja excluir este setor?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  setores.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text("Sim"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}
