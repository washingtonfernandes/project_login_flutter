import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';


import 'package:flutter/widgets.dart';


import 'package:project_vofaze/comum/cores.dart';


import 'package:project_vofaze/services/firestore.dart';


class CadastroSetor extends StatefulWidget {

  const CadastroSetor({super.key});


  @override

  State<CadastroSetor> createState() => _CadastroSetorState();

}


class _CadastroSetorState extends State<CadastroSetor> {

  final FirestoreService firestoreService = FirestoreService();


  final TextEditingController textControler = TextEditingController();


  void openboxSetor({String? docID}) {

    showDialog(

      context: context,

      builder: (content) => AlertDialog(

        content: TextField(

          controller: textControler,

          decoration: InputDecoration(

            focusedBorder: OutlineInputBorder(

              borderSide: BorderSide(color: Colors.black),

            ),

          ),

        ),

        actions: [

          Align(

            alignment: Alignment.center,

            child: ElevatedButton(

              onPressed: () {

                if (docID == null) {

                  firestoreService.addSetor(textControler.text);

                } else {

                  firestoreService.updateSetor(docID, textControler.text);

                }


                textControler.clear();


                Navigator.pop(context);

              },

              style: ElevatedButton.styleFrom(

                foregroundColor: Colors.black,

                backgroundColor: MinhasCores.amarelo,

              ),

              child: Text("Salvar"),

            ),

          ),

        ],

      ),

    );

  }


  void confirmDelete({required String docID}) {

    showDialog(

      context: context,

      builder: (content) => AlertDialog(

        title: Center(

          child: Text("Confirmação"),

        ),

        content: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            Text(

              "Deseja excluir este item?",

              style: TextStyle(color: Colors.black),

            ),

            SizedBox(height: 16),

            Row(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                TextButton(

                  onPressed: () {

                    Navigator.pop(context);

                  },

                  style: ElevatedButton.styleFrom(

                    foregroundColor: Colors.white,

                    backgroundColor: Color.fromARGB(255, 0, 0, 0),

                  ),

                  child: Text(

                    "Cancelar",

                    style: TextStyle(color: Colors.white),

                  ),

                ),

                TextButton(

                  onPressed: () {

                    firestoreService.deleteSetor(docID);


                    Navigator.pop(context);

                  },

                  style: ElevatedButton.styleFrom(

                    foregroundColor: Colors.black,

                    backgroundColor: MinhasCores.amarelo,

                  ),

                  child: Text("Confirmar"),

                ),

              ],

            ),

          ],

        ),

      ),

    );

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor: MinhasCores.amarelo,

        elevation: 0,

        centerTitle: true,

        title: Text("Setores"),

      ),

      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.black,

        foregroundColor: MinhasCores.amarelo,

        onPressed: openboxSetor,

        child: const Icon(Icons.add),

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

            child: StreamBuilder<QuerySnapshot>(

              stream: firestoreService.getSetoresStream(),

              builder: (context, snapshot) {

                if (snapshot.hasData) {

                  List setoresList = snapshot.data!.docs;


                  return ListView.builder(

                    itemCount: setoresList.length,

                    itemBuilder: (context, index) {

                      DocumentSnapshot document = setoresList[index];


                      String docID = document.id;


                      Map<String, dynamic> data =

                          document.data() as Map<String, dynamic>;


                      String setorText = data["setor"];


                      return SingleChildScrollView(

                        child: Padding(

                          padding: const EdgeInsets.all(12.0),

                          child: Container(

                            decoration: BoxDecoration(

                              color: Colors.white,

                              borderRadius: BorderRadius.circular(8.0),

                            ),

                            child: ListTile(

                              title: Text(

                                setorText,

                                style: TextStyle(fontSize: 18),

                              ),

                              trailing: Row(

                                mainAxisSize: MainAxisSize.min,

                                children: [

                                  IconButton(

                                    onPressed: () => openboxSetor(docID: docID),

                                    icon: const Icon(Icons.settings),

                                  ),

                                  IconButton(

                                    onPressed: () =>

                                        confirmDelete(docID: docID),

                                    icon: const Icon(Icons.delete),

                                  ),

                                ],

                              ),

                            ),

                          ),

                        ),

                      );

                    },

                  );

                } else {

                  return const Text("Sem setor...");

                }

              },

            ),

          ),

        ],

      ),

    );

  }

}

