import 'package:json_annotation/json_annotation.dart';

part 'resume.g.dart';

@JsonSerializable()
class Resume {
  String title;

  String wordKey;

  String resume;

  static const fromJson = _$ResumeFromJson;

  Map<String, dynamic> toJson() => _$ResumeToJson(this);
}
