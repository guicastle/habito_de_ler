import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/firebase/fire_store_handler.dart';
import 'package:habito_de_ler/model/book.dart';
import 'package:habito_de_ler/model/book_google.dart';
import 'package:habito_de_ler/utils/space_utils.dart';
import 'package:habito_de_ler/widget/star_display.dart';

class CardSearchBook extends StatefulWidget {
  final int index;
  final bool longPressEnabled;
  final VoidCallback callback;
  final bool isSelected;
  final Items item;

  CardSearchBook(
      {Key key,
      this.index,
      this.longPressEnabled,
      this.callback,
      this.isSelected,
      this.item})
      : super(key: key);

  @override
  _CardSearchBookState createState() => _CardSearchBookState();
}

class _CardSearchBookState extends State<CardSearchBook> {
  @override
  Widget build(BuildContext context) {
    String imageUrl =
        '${widget.item.volumeInfo.imageLinks != null ? widget.item.volumeInfo.imageLinks.thumbnail : 'https://historyexplorer.si.edu/sites/default/files/book-158.jpg'}';
    String title = '${widget.item.volumeInfo.title}';
    String author =
        '${widget.item.volumeInfo.authors != null ? widget.item.volumeInfo.authors[0] : '-'}';
    int averageRating = widget.item.volumeInfo.averageRating != null
        ? widget.item.volumeInfo.averageRating.toInt()
        : 0;

    return GestureDetector(
      onTap: () async {
        widget.callback();

        FireStoreHandler _base = new FireStoreHandler();
        if (widget.isSelected == false) {
          /// Selecionado, inserir item da lista
          Book book = new Book()
            ..bookId = widget.item.volumeInfo.title.replaceAll(" ", "_").toLowerCase()
            ..title = widget.item.volumeInfo.title
            ..authors = widget.item.volumeInfo.authors
            ..publisher = widget.item.volumeInfo.publisher
            ..publishedDate = widget.item.volumeInfo.publishedDate
            ..description = widget.item.volumeInfo.description
            ..pageCount = widget.item.volumeInfo.pageCount
            ..categories = widget.item.volumeInfo.categories
            ..averageRating = widget.item.volumeInfo.averageRating
            ..language = widget.item.volumeInfo.language
            ..imageUrl = widget.item.volumeInfo.imageLinks.thumbnail;

          await _base.setIdData('books', book.toJson(), book.bookId);
        } else {
          /// Não selecionado, excluir item da lista
          var bookId = widget.item.volumeInfo.title.replaceAll(" ", "_").toLowerCase();
          await _base.deleteData('books', bookId);
        }
      },
      child: Container(
        child: buildCardTileBook(
            imageUrl, title, author, averageRating, widget.isSelected),
      ),
    );
  }
}

Widget buildCardTileBook(String picture, String title, String author,
    int averageRating, bool isSelected) {
  return ListTile(
    contentPadding: EdgeInsets.all(18),
    leading: CachedNetworkImage(
      imageUrl: picture,
      fit: BoxFit.cover,
    ),
    title: Text(
      title,
      style: TextStyle(fontSize: 16),
      overflow: TextOverflow.fade,
      maxLines: 1,
      softWrap: false,
    ),
    subtitle: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(author),
          SpaceUtils.column(12),
          IconTheme(
            data: IconThemeData(color: Colors.amber, size: 12),
            child: StarDisplay(
              value: averageRating,
            ),
          )
        ],
      ),
    ),
    trailing: isSelected
        ? Icon(Icons.favorite, color: Colors.green)
        : Icon(Icons.favorite_border),
  );
}
