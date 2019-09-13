import 'package:habito_de_ler/model/book.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String name;

  String email;

  String password;

  List<Book> booksFavorites;

  List<Book> booksReading;

  DateTime createDate;

  static const fromJson = _$UserFromJson;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}