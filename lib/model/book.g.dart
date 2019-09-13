// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  return Book()
    ..bookId = json['bookId'] as String
    ..title = json['title'] as String
    ..authors = (json['authors'] as List)?.map((e) => e as String)?.toList()
    ..publisher = json['publisher'] as String
    ..publishedDate = json['publishedDate'] as String
    ..description = json['description'] as String
    ..pageCount = json['pageCount'] as int
    ..categories =
        (json['categories'] as List)?.map((e) => e as String)?.toList()
    ..averageRating = (json['averageRating'] as num)?.toDouble()
    ..language = json['language'] as String
    ..imageUrl = json['imageUrl'] as String
    ..resumes = (json['resumes'] as List)
        ?.map((e) =>
            e == null ? null : Resume.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..readingGoalPerDay = json['readingGoalPerDay'] as int
    ..timeReading =
        (json['timeReading'] as List)?.map((e) => e as int)?.toList()
    ..readNotification = json['readNotification'] == null
        ? null
        : DateTime.parse(json['readNotification'] as String);
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'bookId': instance.bookId,
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
      'pageCount': instance.pageCount,
      'categories': instance.categories,
      'averageRating': instance.averageRating,
      'language': instance.language,
      'imageUrl': instance.imageUrl,
      'resumes': instance.resumes,
      'readingGoalPerDay': instance.readingGoalPerDay,
      'timeReading': instance.timeReading,
      'readNotification': instance.readNotification?.toIso8601String()
    };
