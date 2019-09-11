import 'dart:convert' as convert;

import 'package:ant_icons/ant_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/application/constants.dart';
import 'package:habito_de_ler/firebase/fire_store_handler.dart';
import 'package:habito_de_ler/model/book.dart';
import 'package:habito_de_ler/model/book_google.dart';
import 'package:habito_de_ler/utils/space_utils.dart';
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

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SpaceUtils.column(44),
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: TextField(
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
                decoration: InputDecoration(
                  hintText: 'Busca o livro (Titulo/Author)',
                  icon: Icon(AntIcons.search_outline),
                ),
              ),
            ),
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
        books.add(Book.fromJson(doc.data));
      }
      for (var item in items) {
        var bookId = item.volumeInfo.title.replaceAll(" ", "_").toLowerCase();
        var result = books.contains(bookId);
        print(result);

        item.isSelected = false;
      }
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }
}
