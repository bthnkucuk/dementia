import 'package:dementia/core/constants/http_constants.dart';
import 'package:dementia/core/exceptions/exceptions.dart';
import 'package:dementia/features/top_animes/data/data_sources/top_animes_network_data_source.dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/top_animes/reader.dart';
@GenerateNiceMocks([
  MockSpec<http.Client>(),
])
import 'top_animes_network_data_source_test.mocks.dart';

void main() {
  late TopAnimesAnimeNetworkDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = TopAnimesAnimeNetworkDataSource(client: mockClient);
  });

  group('getTopAnimesWithPageNumber', () {
    const pageNumber = 1;

    test('get requests when status 200', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(dummyTopAnimesReader(), 200));

      dataSource.getTopAnimesWithPageNumber(pageNumber);

      verify(mockClient.get(
        Uri.https(
          HttpConstants.baseUrl,
          HttpConstants.topAnimePath,
          {
            'page': pageNumber.toString(),
          },
        ),
      ));
    });

    test('get requests when status not 200', () async {
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      final method = dataSource.getTopAnimesWithPageNumber;

      expect(() => method(pageNumber),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
