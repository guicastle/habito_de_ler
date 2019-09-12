import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/firebase/fire_store_handler.dart';
import 'package:habito_de_ler/model/book.dart';
import 'package:habito_de_ler/utils/space_utils.dart';

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
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: _base.getAllSnapshots('books'),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            books.clear();
            for (DocumentSnapshot doc in snapshot.data.documents) {
              Book book = new Book();
              book = Book.fromJson(doc.data);
              book.bookId = doc.documentID;
              books.add(book);
            }
          }
          return Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SpaceUtils.column(18),
                    Container(
                      width: width * 0.9,
                      height: 124,
                      color: Colors.black26,
                      //child: ,
                    ),
                    SpaceUtils.column(18),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  key: Key('listCards'),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: Key(books[index].bookId),
                      onDismissed: (direction) async {
                        var bookId = books[index].bookId;
                        await _base.deleteData('books', bookId);
                        setState(() {
                          books.removeAt(index);
                        });
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(
                            content: Text("${books[index].title} removido")));
                      },
                      background: Container(
                        color: Colors.red[300],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.delete),
                            SpaceUtils.row(24)
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuildCardBook(
                              books[index].imageUrl, books[index].title,
                              books[index].authors, 46,
                              books[index].pageCount)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
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
