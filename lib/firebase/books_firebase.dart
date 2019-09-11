import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habito_de_ler/model/book.dart';

import 'fire_store_handler.dart';

class BooksFireBase extends FireStoreHandler {
  List<Book> books = [];

  Future<List<Book>> getAllBooks() async {
    QuerySnapshot querySnapshot = await getDocumentsSelect('books');

    for (DocumentSnapshot doc in querySnapshot.documents) {
      Book book = Book.fromJson(doc.data);
      book.bookId = doc.documentID;
      books.add(book);
    }

    return books;
  }
}
