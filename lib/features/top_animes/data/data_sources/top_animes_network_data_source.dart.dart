import 'dart:convert';

import 'package:dementia/core/exceptions/exceptions.dart';

import '../../../../core/constants/http_constants.dart';
import 'package:http/http.dart' as http;

import '../models/top_animes/top_animes_model.dart';

class TopAnimesAnimeNetworkDataSource {
  final http.Client client;

  TopAnimesAnimeNetworkDataSource({required this.client});

  Future<TopAnimesModel> getTopAnimesWithPageNumber(int pageNumber,
      {String? type}) async {
    final response = await client.get(
      Uri.https(
        HttpConstants.baseUrl,
        HttpConstants.topAnimePath,
        {
          'page': pageNumber.toString(),
          if (type != null) 'type': type,
        },
      ),
    );

    if (response.statusCode == 200) {
      return TopAnimesModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
