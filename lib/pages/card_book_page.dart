import 'package:flutter/material.dart';

class BuildCardBook extends StatelessWidget {
  final String picture;
  final String title;
  final String author;
  final int numPageCurrent;
  final int numPages;

  BuildCardBook(this.picture, this.title, this.author, this.numPageCurrent,
      this.numPages);

  @override
  Widget build(BuildContext context) {
    /// width * 0.66 = 100%
    var width = MediaQuery.of(context).size.width;

    var _progress = (100 * numPageCurrent) / numPages;
    var percent = ((width * 0.66) * _progress) / 100;

    return Card(
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeInImage.assetNetwork(
            placeholder: '',
            image: picture,
            fit: BoxFit.contain,
            width: 95.0,
            height: 95.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              _getTitleBook(title),
              SizedBox(
                height: 4,
              ),
              _getAuthorBook(author),
              SizedBox(
                height: 32,
              ),

              /// Carregamento de progresso de leitura
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
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
            ],
          )
        ],
      ),
    );
  }

  Widget _getTitleBook(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 14),
      overflow: TextOverflow.fade,
      maxLines: 2,
      softWrap: false,
    );
  }

  Widget _getAuthorBook(String author) {
    return Text(
      author,
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );
  }
}
