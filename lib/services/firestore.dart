import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // SETORES------------------------------------------------

  // buscar coleção de setores
  final CollectionReference setores =
      FirebaseFirestore.instance.collection("setores");

  // adicionar un novo setor
  Future<void> addSetor(String setor) {
    return setores.add({
      "setor": setor,
    });
  }

  // retornar os setores
  Stream<QuerySnapshot> getSetoresStream() {
    final setoresStream =
        setores.orderBy("setor", descending: true).snapshots();
    return setoresStream;
  }

  // alterar
  Future<void> updateSetor(String docID, String newsetor) {
    return setores.doc(docID).update({
      "setor": newsetor,
    });
  }

  // deletar
  Future<void> deleteSetor(String docID) {
    return setores.doc(docID).delete();
  }

  // AMBIENTES -----------------------------------------------------------
  final CollectionReference ambientes =
      FirebaseFirestore.instance.collection("ambientes");

  // adicionar un novo ambiente
  Future<void> addAmbiente(String ambiente) {
    return ambientes.add({
      "ambiente": ambiente,
    });
  }

  // retornar os ambientes
  Stream<QuerySnapshot> getAmbientesStream() {
    final ambientesStream =
        ambientes.orderBy("ambiente", descending: true).snapshots();
    return ambientesStream;
  }

  // alterar
  Future<void> updateAmbiente(String docID, String newambiente) {
    return ambientes.doc(docID).update({
      "ambiente": newambiente,
    });
  }

  // deletar
  Future<void> deleteAmbiente(String docID) {
    return ambientes.doc(docID).delete();
  }

  // USUÁRIOS -----------------------------------------------------------

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

// Retornar os usuários
  Stream<List<Map<String, dynamic>>> getUsuariosStreamWithSensitiveData() {
    final usuariosStream = users.orderBy("nome", descending: true).snapshots();

    return usuariosStream.map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          "nome": data["nome"],
          "email": data["email"],
          "senha": data["senha"],
        };
      }).toList();
    });
  }
}
