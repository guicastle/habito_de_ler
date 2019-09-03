// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..userId = json['userId'] as int
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..password = json['password'] as String
    ..picture = json['picture'] as String
    ..createDate = json['createDate'] == null
        ? null
        : DateTime.parse(json['createDate'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'picture': instance.picture,
      'createDate': instance.createDate?.toIso8601String()
    };
