import 'dart:convert';
import 'package:dementia/features/anime_characters/data/models/anime_characters/anime_characters_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../dummy_data/anime_caracters/reader.dart';

void main() {
  test('anime characters model dummy data fromJson and isEqual tests',
      () async {
    final json =
        jsonDecode(dummyAnimeCharactersReader()) as Map<String, dynamic>;

    final result = AnimeCharactersModel.fromJson(json);
    final result2 = AnimeCharactersModel.fromJson(json);

    expect(result, equals(result2));
    expect(result, isA<AnimeCharactersModel>());
  });
}
