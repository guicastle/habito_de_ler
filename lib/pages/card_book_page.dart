import 'package:flutter/material.dart';

class BuildCardBook extends StatelessWidget {
  final String picture;
  final String title;
  final List<String> authors;
  final int numPageCurrent;
  final int numPages;

  BuildCardBook(this.picture, this.title, this.authors, this.numPageCurrent,
      this.numPages);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    /// width * 0.66 = 100%
    var _progress = (100 * numPageCurrent) / numPages;
    var percent = ((width * 0.66) * _progress) / 100;

    String author = authors != null ? authors[0] : '';
    if (authors.length > 0) {
      for (int i = 0; i < authors.length - 1; i++) {
        author = authors[i] + ',' + authors[i + 1];
      }
    }

    return Card(
      color: Colors.black26,
      child: Row(
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: '',
            image: picture,
            fit: BoxFit.contain,
            width: 95.0,
            height: 95.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: _getTitleBook(title),
                  subtitle: _getAuthorBook(author),
                  contentPadding: EdgeInsets.all(4),
                ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${_progress.toStringAsFixed(2)}%',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: percent,
                    color: Colors.blue[300],
                    padding: EdgeInsets.all(1.0),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }

  Widget _getTitleBook(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      softWrap: true,
    );
  }

  Widget _getAuthorBook(String author) {
    return Text(
      author,
      style: TextStyle(color: Colors.grey, fontSize: 14),
    );
  }
}
