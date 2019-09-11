import 'dart:convert' as convert;

import 'package:ant_icons/ant_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/application/constants.dart';
import 'package:habito_de_ler/firebase/fire_store_handler.dart';
import 'package:habito_de_ler/model/book.dart';
import 'package:habito_de_ler/model/book_google.dart';
 import 'package:habito_de_ler/utils/string_format.dart';
import 'package:habito_de_ler/widget/card_tile_book.dart';
import 'package:habito_de_ler/widget/shimmers/search_card_shimmer.dart';
import 'package:http/http.dart' as http;

class SearchBookPage extends StatefulWidget {
  @override
  _SearchBookPageState createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  List<Items> items = new List<Items>();
  bool loading = false;

  onElementSelected(int index) {
    setState(
      () {
        items[index].isSelected = !items[index].isSelected;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (loading) {
      body = ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return SearchCardShimmer();
        },
      );
    } else {
      body = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CardSearchBook(
            isSelected: items[index].isSelected,
            index: index,
            callback: () {
              onElementSelected(index);
            },
            item: items[index],
          );
        },
      );
    }

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(90.0)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 6,
            child: Theme(
              data: Theme.of(context).copyWith(
                cursorColor: Colors.pinkAccent,
                hintColor: Colors.transparent,
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: new EdgeInsets.symmetric(
                      vertical: 8, horizontal: 12),
                  focusedBorder: border,
                  border: border,
                  prefixIcon: Icon(
                    AntIcons.search_outline,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Colors.white10,
                  hintText: 'Busca o livro (Titulo/Author)',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onSubmitted: (value) async {
                  setState(() {
                    loading = true;
                  });
                  items.clear();
                  await getBookGoogle(value);
                  setState(() {
                    loading = false;
                  });
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );
  }

  getBookGoogle(String value) async {
    BookGoogle bookGoogle = new BookGoogle();
    String searchValue = "";
    searchValue = StringFormat.removeDiacritics(value);
    searchValue = searchValue.replaceAll(" ", "+");

    String url =
        '${Constants.URL_GOOGLE_BOOKS_API}?key=${Constants.API_KEY}&q=$searchValue&maxResults=40&orderBy=relevance';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      bookGoogle = BookGoogle.fromJson(jsonResponse);

      items.addAll(bookGoogle.items);

      //List<Book> books = await _base.getDocuments<Book>('books', );
      FireStoreHandler _base = new FireStoreHandler();
      QuerySnapshot querySnapshot = await _base.getDocumentsSelect('books');
      List<Book> books = [];
      for (DocumentSnapshot doc in querySnapshot.documents) {
        Book book = Book.fromJson(doc.data);
        book.bookId = doc.documentID;
        books.add(book);
      }

      for (var item in items) {
        var bookId = item.volumeInfo.title.replaceAll(" ", "_").toLowerCase();
        bool alreadySelected = books
            .where((i) => i.bookId == bookId)
            .toList()
            .length > 0 ? true : false;
        if (alreadySelected) {
          item.isSelected = true;
        } else {
          item.isSelected = false;
        }
      }
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }
}
