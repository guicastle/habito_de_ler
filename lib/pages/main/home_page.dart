import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/firebase/fire_store_handler.dart';
import 'package:habito_de_ler/model/book.dart';

import '../card_book_page.dart';
import '../search_book_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [];
  FireStoreHandler _base = new FireStoreHandler();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listCards = [];


    Book book = new Book();
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: _base.getAllSnapshots('books'),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            books.clear();
            for (DocumentSnapshot doc in snapshot.data.documents) {
              book = Book.fromJson(doc.data);
              book.bookId = doc.documentID;
              books.add(book);
            }
          }
          return Container(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildCardBook(books[index].imageUrl, books[index].title, books[index].authors, 100,
                        books[index].pageCount)
                  ],
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[700],
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchBookPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
