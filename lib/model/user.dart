import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int userId;

  String name;

  String email;

  String password;

  String picture;

  DateTime createDate;

  static const fromJson = _$UserFromJson;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}