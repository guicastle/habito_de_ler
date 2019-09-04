import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/model/book_google.dart';
import 'package:habito_de_ler/utils/behaviors_utils.dart';
import 'package:habito_de_ler/utils/space_utils.dart';
import 'package:habito_de_ler/application/constants.dart';
import 'package:habito_de_ler/utils/string_format.dart';
import 'package:habito_de_ler/widget/card_tile_book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SearchBookPage extends StatefulWidget {
  @override
  _SearchBookPageState createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    List<Widget> cardsBooks = [];
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SpaceUtils.column(height * 0.06),
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                onSubmitted: (value) async {
                  String searchValue = "";
                  var list = value.split(" ");
                  for (int i = 0; i < list.length; i++) {
                    if (i != list.length - 1) {
                      searchValue += StringFormat.removeDiacritics(list[i]) +
                          "+" +
                          StringFormat.removeDiacritics(list[i + 1]);
                    }
                  }
                  String url =
                      '${Constants.URL_GOOGLE_BOOKS_API}${Constants.API_KEY}&q=$searchValue';

                  var response = await http.get(url);
                  if (response.statusCode == 200) {
                    var jsonResponse = convert.jsonDecode(response.body);
                    BookGoogle bookGoogle = BookGoogle.fromJson(jsonResponse);

                    for (final item in bookGoogle.items) {
                      String picture = item.volumeInfo.imageLinks != null
                          ? item.volumeInfo.imageLinks.thumbnail.toString()
                          : 'https://historyexplorer.si.edu/sites/default/files/book-158.jpg';
                      String title = item.volumeInfo.title != null
                          ? item.volumeInfo.title
                          : '';
                      String author = item.volumeInfo.description != null
                          ? item.volumeInfo.authors[0]
                          : '';
                      //int averageRating = item.volumeInfo.averageRating.toInt();

                      setState(() {
                        cardsBooks.add(
                            buildCardTileBook(picture, title, author, 5));
                      });
                      print(cardsBooks);
                    }
                  } else {}
                },
                decoration: InputDecoration(
                  hintText: 'Busca o livro (Titulo/Author)',
                  icon: Icon(AntIcons.search_outline),
                ),
              ),
            ),
            buildCardTileBook("http://statics.livrariacultura.net.br/products/capas_lg/365/30351365.jpg", "O Poder do Hábito", "Charles Duhigg", 4),
            buildCardTileBook("http://statics.livrariacultura.net.br/products/capas_lg/786/1495786.jpg", "Os Segredos da Mente Milionária", "T. Harv Eker", 5),
//            ListView(
//              children: cardsBooks,
//            ),
          ],
        ),
      ),
    );
  }
}
