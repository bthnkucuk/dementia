import 'dart:convert';

import 'package:dementia/core/exceptions/exceptions.dart';

import '../../../../../core/constants/http_constants.dart';
import 'package:http/http.dart' as http;

import '../models/anime_characters/anime_characters_model.dart';

/// [AnimeCharactersNetworkDataSource] is a class that provides anime characters data from the network.
class AnimeCharactersNetworkDataSource {
  final http.Client client;

  AnimeCharactersNetworkDataSource({required this.client});

  Future<AnimeCharactersModel> getAnimeCharacters(int animeId) async {
    final response = await client.get(
      Uri.https(
        HttpConstants.baseUrl,
        '${HttpConstants.animeDetailPath}/$animeId/${HttpConstants.animeCharactersPath}',
      ),
    );

    if (response.statusCode == 200) {
      return AnimeCharactersModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
