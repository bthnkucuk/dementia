// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'anime_reviews_model.freezed.dart';
part 'anime_reviews_model.g.dart';

@freezed
class AnimeReviewsModel with _$AnimeReviewsModel {
  const factory AnimeReviewsModel({
    required Pagination pagination,
    required List<Datum> data,
  }) = _AnimeReviewsModel;

  factory AnimeReviewsModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeReviewsModelFromJson(json);
}

@freezed
class Datum with _$Datum {
  const factory Datum({
    @JsonKey(name: 'mal_id') required int malId,
    required String? url,
    required String? type,
    required String? review,
    required List<String> tags,
    @JsonKey(name: 'is_spoiler') required bool? isSpoiler,
    @JsonKey(name: 'is_preliminary') required bool? isPreliminary,
    @JsonKey(name: 'episodes_watched') required dynamic episodesWatched,
    required User user,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    required String? url,
    required String? username,
    required Map<String, Image> images,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Image with _$Image {
  const factory Image({
    @JsonKey(name: 'image_url') required String? imageUrl,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    @JsonKey(name: 'last_visible_page') required int? lastVisiblePage,
    @JsonKey(name: 'has_next_page') required bool? hasNextPage,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
