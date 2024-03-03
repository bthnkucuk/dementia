import 'dart:convert';
import 'package:dementia/features/anime_reviews/data/models/anime_reviews/anime_reviews_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../dummy_data/anime_reviews/reader.dart';

void main() {
  test('anime reviews model dummy data fromJson and isEqual tests', () async {
    final json = jsonDecode(dummyAnimeReviewsReader()) as Map<String, dynamic>;

    final result = AnimeReviewsModel.fromJson(json);
    final result2 = AnimeReviewsModel.fromJson(json);

    expect(result, equals(result2));
    expect(result, isA<AnimeReviewsModel>());
  });
}
