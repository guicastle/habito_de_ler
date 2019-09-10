import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 12, right: 12),
      leading: Shimmer.fromColors(
        baseColor: Colors.black26,
        highlightColor: Colors.black38,
        child: Container(
          width: 38.0,
          height: 48.0,
          decoration: BoxDecoration(
            color: Colors.grey[400],
          ),
        ),
      ),
      title: Shimmer.fromColors(
        baseColor: Colors.black26,
        highlightColor: Colors.black38,
        child: Container(
          margin: EdgeInsets.only(right: 64),
          height: 12,
          color: Colors.grey[400],
        ),
      ),
      subtitle: Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.black38,
        child: Container(
          margin: EdgeInsets.only(right: 88),
          height: 10,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
