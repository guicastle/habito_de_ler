// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_google.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookGoogle _$BookGoogleFromJson(Map<String, dynamic> json) {
  return BookGoogle(
      kind: json['kind'] as String,
      totalItems: json['totalItems'] as int,
      items: (json['items'] as List)
          ?.map((e) =>
              e == null ? null : Items.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$BookGoogleToJson(BookGoogle instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items
    };

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
      kind: json['kind'] as String,
      id: json['id'] as String,
      etag: json['etag'] as String,
      selfLink: json['selfLink'] as String,
      volumeInfo: json['volumeInfo'] == null
          ? null
          : VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
      saleInfo: json['saleInfo'] == null
          ? null
          : SaleInfo.fromJson(json['saleInfo'] as Map<String, dynamic>),
      searchInfo: json['searchInfo'] == null
          ? null
          : SearchInfo.fromJson(json['searchInfo'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'etag': instance.etag,
      'selfLink': instance.selfLink,
      'volumeInfo': instance.volumeInfo,
      'saleInfo': instance.saleInfo,
      'searchInfo': instance.searchInfo
    };

VolumeInfo _$VolumeInfoFromJson(Map<String, dynamic> json) {
  return VolumeInfo(
      title: json['title'] as String,
      authors: (json['authors'] as List)?.map((e) => e as String)?.toList(),
      publisher: json['publisher'] as String,
      publishedDate: json['publishedDate'] as String,
      description: json['description'] as String,
      pageCount: json['pageCount'] as int,
      printType: json['printType'] as String,
      categories:
          (json['categories'] as List)?.map((e) => e as String)?.toList(),
      averageRating: json['averageRating'] as double,
      ratingsCount: json['ratingsCount'] as int,
      maturityRating: json['maturityRating'] as String,
      allowAnonLogging: json['allowAnonLogging'] as bool,
      contentVersion: json['contentVersion'] as String,
      imageLinks: json['imageLinks'] == null
          ? null
          : ImageLinks.fromJson(json['imageLinks'] as Map<String, dynamic>),
      language: json['language'] as String,
      previewLink: json['previewLink'] as String,
      infoLink: json['infoLink'] as String,
      canonicalVolumeLink: json['canonicalVolumeLink'] as String);
}

Map<String, dynamic> _$VolumeInfoToJson(VolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
      'pageCount': instance.pageCount,
      'printType': instance.printType,
      'categories': instance.categories,
      'averageRating': instance.averageRating,
      'ratingsCount': instance.ratingsCount,
      'maturityRating': instance.maturityRating,
      'allowAnonLogging': instance.allowAnonLogging,
      'contentVersion': instance.contentVersion,
      'imageLinks': instance.imageLinks,
      'language': instance.language,
      'previewLink': instance.previewLink,
      'infoLink': instance.infoLink,
      'canonicalVolumeLink': instance.canonicalVolumeLink
    };

ImageLinks _$ImageLinksFromJson(Map<String, dynamic> json) {
  return ImageLinks(
      smallThumbnail: json['smallThumbnail'] as String,
      thumbnail: json['thumbnail'] as String);
}

Map<String, dynamic> _$ImageLinksToJson(ImageLinks instance) =>
    <String, dynamic>{
      'smallThumbnail': instance.smallThumbnail,
      'thumbnail': instance.thumbnail
    };

SaleInfo _$SaleInfoFromJson(Map<String, dynamic> json) {
  return SaleInfo(
      country: json['country'] as String,
      saleability: json['saleability'] as String,
      isEbook: json['isEbook'] as bool,
      listPrice: json['listPrice'] == null
          ? null
          : ListPrice.fromJson(json['listPrice'] as Map<String, dynamic>),
      retailPrice: json['retailPrice'] == null
          ? null
          : RetailPrice.fromJson(json['retailPrice'] as Map<String, dynamic>),
      buyLink: json['buyLink'] as String,
      offers: (json['offers'] as List)
          ?.map((e) =>
              e == null ? null : Offers.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SaleInfoToJson(SaleInfo instance) => <String, dynamic>{
      'country': instance.country,
      'saleability': instance.saleability,
      'isEbook': instance.isEbook,
      'listPrice': instance.listPrice,
      'retailPrice': instance.retailPrice,
      'buyLink': instance.buyLink,
      'offers': instance.offers
    };

Offers _$OffersFromJson(Map<String, dynamic> json) {
  return Offers(
      finskyOfferType: json['finskyOfferType'] as int,
      listPrice: json['listPrice'] == null
          ? null
          : ListPrice.fromJson(json['listPrice'] as Map<String, dynamic>),
      retailPrice: json['retailPrice'] == null
          ? null
          : RetailPrice.fromJson(json['retailPrice'] as Map<String, dynamic>),
      giftable: json['giftable'] as bool);
}

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'finskyOfferType': instance.finskyOfferType,
      'listPrice': instance.listPrice,
      'retailPrice': instance.retailPrice,
      'giftable': instance.giftable
    };

ListPrice _$ListPriceFromJson(Map<String, dynamic> json) {
  return ListPrice(
      amountInMicros: json['amountInMicros'] as double,
      currencyCode: json['currencyCode'] as String);
}

Map<String, dynamic> _$ListPriceToJson(ListPrice instance) => <String, dynamic>{
      'amountInMicros': instance.amountInMicros,
      'currencyCode': instance.currencyCode
    };

RetailPrice _$RetailPriceFromJson(Map<String, dynamic> json) {
  return RetailPrice(
      amountInMicros: json['amountInMicros'] as double,
      currencyCode: json['currencyCode'] as String);
}

Map<String, dynamic> _$RetailPriceToJson(RetailPrice instance) =>
    <String, dynamic>{
      'amountInMicros': instance.amountInMicros,
      'currencyCode': instance.currencyCode
    };

SearchInfo _$SearchInfoFromJson(Map<String, dynamic> json) {
  return SearchInfo(textSnippet: json['textSnippet'] as String);
}

Map<String, dynamic> _$SearchInfoToJson(SearchInfo instance) =>
    <String, dynamic>{'textSnippet': instance.textSnippet};
