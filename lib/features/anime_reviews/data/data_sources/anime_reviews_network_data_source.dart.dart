import 'dart:convert';

import 'package:dementia/core/exceptions/exceptions.dart';
import '../../../../core/constants/http_constants.dart';
import 'package:http/http.dart' as http;

import '../models/anime_reviews/anime_reviews_model.dart';

/// [AnimeReviewsNetworkDataSource] is a class that provides anime reviews data from the network.
class AnimeReviewsNetworkDataSource {
  final http.Client client;

  AnimeReviewsNetworkDataSource({required this.client});

  Future<AnimeReviewsModel> getAnimeReviews(int animeId) async {
    final response = await client.get(
      Uri.https(
        HttpConstants.baseUrl,
        '${HttpConstants.animeDetailPath}/$animeId/${HttpConstants.animeReviewsPath}',
      ),
    );

    if (response.statusCode == 200) {
      return AnimeReviewsModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
