// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'anime_characters_model.freezed.dart';
part 'anime_characters_model.g.dart';

@freezed
class AnimeCharactersModel with _$AnimeCharactersModel {
  const factory AnimeCharactersModel({
    required List<Datum> data,
  }) = _AnimeDetailModel;

  factory AnimeCharactersModel.fromJson(Map<String, dynamic> json) =>
      _$AnimeCharactersModelFromJson(json);
}

@freezed
class Datum with _$Datum {
  const factory Datum({
    required Character character,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}

@freezed
class Character with _$Character {
  const factory Character({
    @JsonKey(name: 'mal_id') required int malId,
    required String url,
    required CharacterImages images,
    required String name,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

@freezed
class CharacterImages with _$CharacterImages {
  const factory CharacterImages({
    required Jpg jpg,
  }) = _CharacterImages;

  factory CharacterImages.fromJson(Map<String, dynamic> json) =>
      _$CharacterImagesFromJson(json);
}

@freezed
class Jpg with _$Jpg {
  const factory Jpg({
    @JsonKey(name: 'image_url') required String imageUrl,
  }) = _Jpg;

  factory Jpg.fromJson(Map<String, dynamic> json) => _$JpgFromJson(json);
}

@freezed
class Person with _$Person {
  const factory Person({
    @JsonKey(name: 'mal_id') required int malId,
    required PersonImages images,
    required String name,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}

@freezed
class PersonImages with _$PersonImages {
  const factory PersonImages({
    required Jpg jpg,
  }) = _PersonImages;

  factory PersonImages.fromJson(Map<String, dynamic> json) =>
      _$PersonImagesFromJson(json);
}
