import 'package:json_annotation/json_annotation.dart';

part 'book_google.g.dart';

@JsonSerializable()
class BookGoogle {
  String kind;
  int totalItems;
  List<Items> items;

  BookGoogle({this.kind, this.totalItems, this.items});

  static const fromJson = _$BookGoogleFromJson;

  Map<String, dynamic> toJson() => _$BookGoogleToJson(this);
}

@JsonSerializable()
class Items {
  String kind;
  String id;
  String etag;
  String selfLink;
  VolumeInfo volumeInfo;
  SaleInfo saleInfo;
  SearchInfo searchInfo;
  bool isSelected;

  Items(
      {this.kind,
      this.id,
      this.etag,
      this.selfLink,
      this.volumeInfo,
      this.saleInfo,
      this.searchInfo,
      this.isSelected});

  static const fromJson = _$ItemsFromJson;

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class VolumeInfo {
  String title;
  List<String> authors;
  String publisher;
  String publishedDate;
  String description;
  int pageCount;
  String printType;
  List<String> categories;
  double averageRating;
  int ratingsCount;
  String maturityRating;
  bool allowAnonLogging;
  String contentVersion;
  ImageLinks imageLinks;
  String language;
  String previewLink;
  String infoLink;
  String canonicalVolumeLink;

  VolumeInfo(
      {this.title,
      this.authors,
      this.publisher,
      this.publishedDate,
      this.description,
      this.pageCount,
      this.printType,
      this.categories,
      this.averageRating,
      this.ratingsCount,
      this.maturityRating,
      this.allowAnonLogging,
      this.contentVersion,
      this.imageLinks,
      this.language,
      this.previewLink,
      this.infoLink,
      this.canonicalVolumeLink});

  static const fromJson = _$VolumeInfoFromJson;

  Map<String, dynamic> toJson() => _$VolumeInfoToJson(this);
}

@JsonSerializable()
class ImageLinks {
  String smallThumbnail;
  String thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  static const fromJson = _$ImageLinksFromJson;

  Map<String, dynamic> toJson() => _$ImageLinksToJson(this);
}

@JsonSerializable()
class SaleInfo {
  String country;
  String saleability;
  bool isEbook;
  ListPrice listPrice;
  RetailPrice retailPrice;
  String buyLink;
  List<Offers> offers;

  SaleInfo(
      {this.country,
      this.saleability,
      this.isEbook,
      this.listPrice,
      this.retailPrice,
      this.buyLink,
      this.offers});

  static const fromJson = _$SaleInfoFromJson;

  Map<String, dynamic> toJson() => _$SaleInfoToJson(this);
}

@JsonSerializable()
class Offers {
  int finskyOfferType;
  ListPrice listPrice;
  RetailPrice retailPrice;
  bool giftable;

  Offers(
      {this.finskyOfferType, this.listPrice, this.retailPrice, this.giftable});

  static const fromJson = _$OffersFromJson;

  Map<String, dynamic> toJson() => _$OffersToJson(this);
}

@JsonSerializable()
class ListPrice {
  double amountInMicros;
  String currencyCode;

  ListPrice({this.amountInMicros, this.currencyCode});

  static const fromJson = _$ListPriceFromJson;

  Map<String, dynamic> toJson() => _$ListPriceToJson(this);
}

@JsonSerializable()
class RetailPrice {
  double amountInMicros;
  String currencyCode;

  RetailPrice({this.amountInMicros, this.currencyCode});

  static const fromJson = _$RetailPriceFromJson;

  Map<String, dynamic> toJson() => _$RetailPriceToJson(this);
}

@JsonSerializable()
class SearchInfo {
  String textSnippet;

  SearchInfo({this.textSnippet});

  static const fromJson = _$SearchInfoFromJson;

  Map<String, dynamic> toJson() => _$SearchInfoToJson(this);
}
