import 'package:dementia/core/constants/http_constants.dart';
import 'package:dementia/core/exceptions/exceptions.dart';
import 'package:dementia/features/anime_reviews/data/data_sources/anime_reviews_network_data_source.dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/anime_reviews/reader.dart';
@GenerateNiceMocks([
  MockSpec<http.Client>(),
])
import 'anime_reviews_network_data_source_test.mocks.dart';

void main() {
  late AnimeReviewsNetworkDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = AnimeReviewsNetworkDataSource(client: mockClient);
  });

  group('getAnimeReviews', () {
    const animeId = 1;

    test('get requests when status 200', () async {
      when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(dummyAnimeReviewsReader(), 200));

      dataSource.getAnimeReviews(animeId);

      verify(mockClient.get(
        Uri.https(
          HttpConstants.baseUrl,
          '${HttpConstants.animeDetailPath}/$animeId/${HttpConstants.animeReviewsPath}',
        ),
      ));
    });

    test('get requests when status not 200', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      final method = dataSource.getAnimeReviews;

      expect(
          () => method(animeId), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
