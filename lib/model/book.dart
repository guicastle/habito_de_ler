import 'package:habito_de_ler/model/resume.dart';
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

  List<Resume> resumes;

  /// Tempo em segundos de meta de leitura por dia
  int readingGoalPerDay;

  /// Tempo em segundos do cronometro [0 - 2000, 1 - 3000] -> Segunda leitura em 5 minutos
  List<int> timeReading;

  /// Alerta para notificar a leitura - Inicial
  DateTime readNotification;

  /// Data de previsão de quando ele vai terminar
  //  DateTime dateFinish;

  static const fromJson = _$BookFromJson;

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
