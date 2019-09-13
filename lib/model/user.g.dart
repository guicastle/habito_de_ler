// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..password = json['password'] as String
    ..booksFavorites = (json['booksFavorites'] as List)
        ?.map(
            (e) => e == null ? null : Book.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..booksReading = (json['booksReading'] as List)
        ?.map(
            (e) => e == null ? null : Book.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..createDate = json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'booksFavorites': instance.booksFavorites,
      'booksReading': instance.booksReading,
      'createDate': instance.createDate?.toIso8601String()
    };
