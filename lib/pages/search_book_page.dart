import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/model/book_google.dart';
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
  List<Items> items = new List<Items>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SpaceUtils.column(44),
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: TextField(
                onSubmitted: (value) async {
                  items.clear();
                  await getBookGoogle(value);
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Busca o livro (Titulo/Author)',
                  icon: Icon(AntIcons.search_outline),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  String imageUrl =
                      '${items[index].volumeInfo.imageLinks != null ? items[index].volumeInfo.imageLinks.thumbnail : 'https://historyexplorer.si.edu/sites/default/files/book-158.jpg'}';
                  String title = '${items[index].volumeInfo.title}';
                  String author =
                      '${items[index].volumeInfo.authors != null ? items[index].volumeInfo.authors[0] : '-'}';
                  int averageRating =
                      items[index].volumeInfo.averageRating != null
                          ? items[index].volumeInfo.averageRating.toInt()
                          : 0;

                  return buildCardTileBook(imageUrl, title, author, averageRating);
                },
              ),
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
      setState(() {});
    } else {
      print(response.statusCode);
      print(response.body);

    }
  }
}
