import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  String bookId;

  String title;

  List<String> authors;

  String publisher;

  String publishedDate;

  String description;

  int pageCount;

  List<String> categories;

  double averageRating;

  String language;

  String imageUrl;

  static const fromJson = _$BookFromJson;

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
