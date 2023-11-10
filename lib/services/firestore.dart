import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // SETORES

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

  // adeletar
  Future<void> deleteSetor(String docID) {
    return setores.doc(docID).delete();
  }

  // AMBIENTES ----------------------------------------------
  final CollectionReference ambientes =
      FirebaseFirestore.instance.collection("ambientes");

  // adicionar un novo setor
  Future<void> addAmbiente(String ambiente) {
    return ambientes.add({
      "ambiente": ambiente,
    });
  }

  // retornar os setores
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

  // adeletar
  Future<void> deleteAmbiente(String docID) {
    return ambientes.doc(docID).delete();
  }
}
