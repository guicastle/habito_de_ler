// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book()
    ..bookId = json['bookId'] as int
    ..title = json['title'] as String
    ..author = json['author'] as String
    ..summary = json['summary'] as String
    ..genre = json['genre'] as String
    ..numPages = json['numPages'] as int
    ..year = json['year'] as int
    ..picture = json['picture'] as String
    ..publisher = json['publisher'] as String
    ..status = json['status'] as String;
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'bookId': instance.bookId,
      'title': instance.title,
      'author': instance.author,
      'summary': instance.summary,
      'genre': instance.genre,
      'numPages': instance.numPages,
      'year': instance.year,
      'picture': instance.picture,
      'publisher': instance.publisher,
      'status': instance.status
    };
