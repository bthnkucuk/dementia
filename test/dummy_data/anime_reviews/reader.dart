import 'dart:io';

String dummyAnimeReviewsReader() =>
    File('test/dummy_data/anime_reviews/anime_reviews.json').readAsStringSync();
