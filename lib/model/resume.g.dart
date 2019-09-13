// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resume _$ResumeFromJson(Map<String, dynamic> json) {
  return Resume()
    ..title = json['title'] as String
    ..wordKey = json['wordKey'] as String
    ..resume = json['resume'] as String;
}

Map<String, dynamic> _$ResumeToJson(Resume instance) => <String, dynamic>{
      'title': instance.title,
      'wordKey': instance.wordKey,
      'resume': instance.resume
    };
