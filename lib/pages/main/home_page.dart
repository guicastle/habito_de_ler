import 'package:flutter/material.dart';
import 'package:habito_de_ler/firebase/books_firebase.dart';
import 'package:habito_de_ler/model/book.dart';

import '../card_book_page.dart';
import '../search_book_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [];
  BooksFireBase _base = new BooksFireBase();

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  loadBooks() async {
    books = await _base.getAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listCards = [];

    if (books.length == 0) {

    } else {
      for (var book in books) {
        var card = BuildCardBook(
            book.imageUrl, book.title, book.authors, 100, book.pageCount);
        listCards.add(card);
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: listCards
          ),
        ),
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
