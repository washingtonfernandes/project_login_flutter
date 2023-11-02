import 'package:flutter/material.dart';
import 'dart:io';
import 'package:project_filtro/comum/cores.dart';

class ListaTickets {
  int id;
  String usuario;
  String ambientes;
  String setorNome; // Alterado o nome do parâmetro
  DateTime dataEntrega;
  String descricao;
  File? image;

  ListaTickets({
    required this.id,
    required this.usuario,
    required this.ambientes,
    required this.setorNome, // Alterado o nome do parâmetro
    required this.dataEntrega,
    required this.descricao,
    this.image,
  });
}

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<ListaTickets> tickets = [
    ListaTickets(
      id: 1,
      usuario: 'Alice',
      ambientes: 'Sala',
      setorNome: 'Manutenção', // Alterado o nome do parâmetro
      dataEntrega: DateTime(2023, 10, 21, 12, 0),
      descricao: 'Consertar Piso',
    ),
    ListaTickets(
      id: 2,
      usuario: 'João',
      ambientes: '204',
      setorNome: 'Manutenção', // Alterado o nome do parâmetro
      dataEntrega: DateTime(2023, 11, 21, 14, 30),
      descricao: 'Consertar Lâmpada',
    ),
  ];

  List<String> usuarios = ["Alice", "João", "Maria"];
  List<String> ambientes = ["Sala", "204", "Escritório"];
  List<String> setores = ["Manutenção", "Limpeza", "TI"];

  @override
  void initState() {
    super.initState();
  }

  void filterItems(String query) {
    query = query.toLowerCase();
    setState(() {
      tickets = tickets.where((item) {
        return item.usuario.toLowerCase().contains(query) ||
            item.ambientes.toLowerCase().contains(query) ||
            item.setorNome
                .toLowerCase()
                .contains(query) || // Alterado o nome do parâmetro
            item.dataEntrega.toString().contains(query) ||
            item.descricao.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Meus tickets",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    MinhasCores.amarelo,
                    MinhasCores.amareloBaixo,
                  ],
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: TextField(
                onChanged: filterItems,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Pesquisar",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [MinhasCores.amarelo, MinhasCores.amarelo],
                  ),
                ),
                child: ListView.builder(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    return buildTicketCard(tickets[index]);
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTicketDialog();
          },
          backgroundColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildTicketCard(ListaTickets ticket) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [MinhasCores.amareloBaixo, Colors.white],
          ),
          borderRadius: BorderRadius.circular(10.0), // Borda arredondada
        ),
        child: Column(
          children: [
            ListTile(
              title: Text("ID: ${ticket.id}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Usuário: ${ticket.usuario}"),
                  Text("Ambientes: ${ticket.ambientes}"),
                  Text(
                      "Setor: ${ticket.setorNome}"), // Alterado o nome do parâmetro
                  Text("Data de Entrega: ${ticket.dataEntrega}"),
                  Text("Descrição: ${ticket.descricao}"),
                ],
              ),
            ),
            if (ticket.image != null) Image.file(ticket.image!),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.black,
                  ),
                  label: Text(
                    "",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showEditTicketDialog(ticket);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  label: Text(
                    "Editar",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellowAccent,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    deleteTicket(ticket);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: Text(
                    "Excluir",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAddTicketDialog() {
    int nextId = tickets.length + 1;
    String selectedUsuario = usuarios[0];
    String selectedAmbiente = ambientes[0];
    String selectedSetor = setores[0];
    DateTime selectedDate = DateTime.now();
    final TextEditingController descricaoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            color: MinhasCores.amarelo,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Adicione um novo ticket",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("ID: $nextId"),
                buildDropdownButton(
                  selectedUsuario,
                  usuarios,
                  (String? newValue) {
                    setState(() {
                      selectedUsuario = newValue!;
                    });
                  },
                ),
                buildDropdownButton(
                  selectedAmbiente,
                  ambientes,
                  (String? newValue) {
                    setState(() {
                      selectedAmbiente = newValue!;
                    });
                  },
                ),
                buildDropdownButton(
                  selectedSetor,
                  setores,
                  (String? newValue) {
                    setState(() {
                      selectedSetor = newValue!;
                    });
                  },
                ),
                buildDateSelector(selectedDate),
                buildDescriptionTextField(descricaoController),
              ],
            ),
          ),
          actions: [
            buildCancelButton(),
            buildAddButton(nextId, selectedUsuario, selectedAmbiente,
                selectedSetor, selectedDate, descricaoController),
          ],
        );
      },
    );
  }

  Widget buildDropdownButton(
      String value, List<String> items, void Function(String?) onChanged) {
    return DropdownButton<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget buildDateSelector(DateTime selectedDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Data de Entrega: "),
        TextButton(
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            ).then((pickedDate) {
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            });
          },
          child: Text(
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ${selectedDate.hour}:${selectedDate.minute}",
          ),
        ),
      ],
    );
  }

  Widget buildDescriptionTextField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: "Descrição"),
    );
  }

  Widget buildCancelButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        onPrimary: Colors.black,
        shadowColor: Colors.deepOrange,
      ),
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget buildAddButton(
      int nextId,
      String selectedUsuario,
      String selectedAmbiente,
      String selectedSetor,
      DateTime selectedDate,
      TextEditingController descricaoController) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        onPrimary: Colors.black,
        shadowColor: Colors.greenAccent,
      ),
      child: Text("Adicionar"),
      onPressed: () {
        final newItem = ListaTickets(
          id: nextId,
          usuario: selectedUsuario,
          ambientes: selectedAmbiente,
          setorNome: selectedSetor, // Alterado o nome do parâmetro
          dataEntrega: selectedDate,
          descricao: descricaoController.text,
          image: null,
        );
        setState(() {
          tickets.add(newItem);
        });
        descricaoController.clear();
        filterItems("");
        Navigator.of(context).pop();
      },
    );
  }

  void showEditTicketDialog(ListaTickets ticket) {
    TextEditingController descricaoController =
        TextEditingController(text: ticket.descricao);
    String selectedUsuario = ticket.usuario;
    String selectedAmbiente = ticket.ambientes;
    String selectedSetor = ticket.setorNome; // Alterado o nome do parâmetro

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            color: MinhasCores.amarelo,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Editar Ticket",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildDropdownButton(
                  selectedUsuario,
                  usuarios,
                  (String? newValue) {
                    setState(() {
                      selectedUsuario = newValue!;
                    });
                  },
                ),
                buildDropdownButton(
                  selectedAmbiente,
                  ambientes,
                  (String? newValue) {
                    setState(() {
                      selectedAmbiente = newValue!;
                    });
                  },
                ),
                buildDropdownButton(
                  selectedSetor,
                  setores,
                  (String? newValue) {
                    setState(() {
                      selectedSetor = newValue!;
                    });
                  },
                ),
                buildDescriptionTextField(descricaoController),
              ],
            ),
          ),
          actions: [
            buildCancelButton(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.black,
                shadowColor: Colors.greenAccent,
              ),
              child: Text("Salvar"),
              onPressed: () {
                setState(() {
                  ticket.usuario = selectedUsuario;
                  ticket.ambientes = selectedAmbiente;
                  ticket.setorNome =
                      selectedSetor; // Alterado o nome do parâmetro
                  ticket.descricao = descricaoController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteTicket(ListaTickets ticket) {
    setState(() {
      tickets.remove(ticket);
    });
  }
}
