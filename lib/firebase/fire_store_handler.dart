import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHandler {
  /// Metodo para geração generica de qualquer entidade
  /// Exemplo: addData(OBJETO.toJson(), 'Caminho'); CREATE AND INSERT INTO
  Future<void> addDocument(String collectionPath, document) async {
    await collection(collectionPath).add(document).catchError((e) {
      print('Error  $e');
    });
  }

  /// Busca todas informações da tabela
  Future<List<T>> getDocuments<T>(String collectionPath, T converter(Map<String, dynamic> map)) async {
    List<T> docs = [];
    QuerySnapshot querySnapshot =
    await collection(collectionPath).getDocuments();

    querySnapshot.documents.forEach((doc) => converter(doc.data));

    return docs;
  }

  Future<QuerySnapshot> getDocumentsSelect(String collectionPath) async {
    QuerySnapshot querySnapshot =
    await collection(collectionPath).getDocuments();

    return querySnapshot;
  }

  /// Retorna se o documento existe
  bool exists(String collectionPath, String documentID) =>
      collection(collectionPath).document().documentID == documentID;

  /// Atualiza informações de qualquer tabela
  /// Exemplo: update('elections', 'ksdi12nnsa1', OBJETO.toJson())
  void updateData(String collectionPath, String documentID, document) async {
    await collection(collectionPath).document(documentID).updateData(document);
  }

  /// Insere em tabela já preenchida
  Future<void> setData(String pathTable, cardData) async {
    await collection(pathTable).document().setData(cardData);
  }

  /// Insere em tabela já preenchida
  Future<void> setIdData(String pathTable, cardData, String document) async {
    await collection(pathTable).document(document).setData(cardData);
  }

  /// Insere em tabela já preenchida
  Future<void> deleteData(String pathTable, String id) async {
    await collection(pathTable).document(id).delete();
  }

  ///Obtém a referência para uma coleção de dados
  CollectionReference collection(String collection) {
    return Firestore.instance.collection(collection);
  }
}