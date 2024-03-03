// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'top_animes_model.freezed.dart';
part 'top_animes_model.g.dart';

@freezed
class TopAnimesModel with _$TopAnimesModel {
  const factory TopAnimesModel({
    required Pagination pagination,
    required List<SingleAnimeGeneralInfo> data,
  }) = _TopAnimesModel;

  factory TopAnimesModel.fromJson(Map<String, dynamic> json) =>
      _$TopAnimesModelFromJson(json);
}

@freezed
class SingleAnimeGeneralInfo with _$SingleAnimeGeneralInfo {
  const factory SingleAnimeGeneralInfo({
    @JsonKey(name: 'mal_id') required int malId,
    required String url,
    required Map<String, Image> images,
    required Trailer trailer,
    required String? title,
    @JsonKey(name: 'title_synonyms') required List<String> titleSynonyms,
    required String? type,
    required String? source,
    required int? episodes,
    required String? status,
    required bool? airing,
    required Aired? aired,
    required String? duration,
    required String? rating,
    required double score,
    required int? rank,
    required int? popularity,
    required int? favorites,
    required String? synopsis,
    required String? background,
    required String? season,
    required int? year,
    required List<Demographic> genres,
  }) = _Datum;

  factory SingleAnimeGeneralInfo.fromJson(Map<String, dynamic> json) =>
      _$SingleAnimeGeneralInfoFromJson(json);
}

@freezed
class Aired with _$Aired {
  const factory Aired({
    required DateTime from,
    required DateTime? to,
    required Prop prop,
    required String? string,
  }) = _Aired;

  factory Aired.fromJson(Map<String, dynamic> json) => _$AiredFromJson(json);
}

@freezed
class Prop with _$Prop {
  const factory Prop({
    required From from,
    required From to,
  }) = _Prop;

  factory Prop.fromJson(Map<String, dynamic> json) => _$PropFromJson(json);
}

@freezed
class From with _$From {
  const factory From({
    required int? day,
    required int? month,
    required int? year,
  }) = _From;

  factory From.fromJson(Map<String, dynamic> json) => _$FromFromJson(json);
}

@freezed
class Demographic with _$Demographic {
  const factory Demographic({
    @JsonKey(name: 'mal_id') required int? malId,
    required String? type,
    required String? name,
    required String? url,
  }) = _Demographic;

  factory Demographic.fromJson(Map<String, dynamic> json) =>
      _$DemographicFromJson(json);
}

@freezed
class Image with _$Image {
  const factory Image({
    @JsonKey(name: 'image_url') required String? imageUrl,
    @JsonKey(name: 'small_image_url') required String? smallImageUrl,
    @JsonKey(name: 'large_image_url') required String? largeImageUrl,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

@freezed
class Title with _$Title {
  const factory Title({
    required String? type,
    required String? title,
  }) = _Title;

  factory Title.fromJson(Map<String, dynamic> json) => _$TitleFromJson(json);
}

@freezed
class Trailer with _$Trailer {
  const factory Trailer({
    required String? url,
  }) = _Trailer;

  factory Trailer.fromJson(Map<String, dynamic> json) =>
      _$TrailerFromJson(json);
}

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    @JsonKey(name: 'last_visible_page') required int? lastVisiblePage,
    @JsonKey(name: 'has_next_page') required bool hasNextPage,
    @JsonKey(name: 'current_page') required int currentPage,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
