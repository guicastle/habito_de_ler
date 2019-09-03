import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  int bookId;

  String title;

  String author;

  String summary;

  String genre;

  int numPages;

  int year;

  String picture;

  String publisher;

  String status;

  static const fromJson = _$BookFromJson;

  Map<String, dynamic> toJson() => _$BookToJson(this);
}