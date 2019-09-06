import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/utils/space_utils.dart';
import 'package:habito_de_ler/widget/star_display.dart';

Widget buildCardTileBook(
    String picture, String title, String author, int averageRating) {
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
    trailing: Icon(
      AntIcons.plus_circle_outline,
      size: 38,
      color: Colors.grey,
    ),
  );
}
