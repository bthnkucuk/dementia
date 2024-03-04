import 'dart:convert';

import 'package:dementia/core/exceptions/exceptions.dart';
import 'package:dementia/core/failures/failures.dart';
import 'package:dementia/core/helpers/network_info.dart';
import 'package:dementia/features/top_animes/data/data_sources/top_animes_network_data_source.dart.dart';
import 'package:dementia/features/top_animes/data/models/top_animes/top_animes_model.dart';
import 'package:dementia/features/top_animes/data/repositories/top_animes_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../dummy_data/top_animes/reader.dart';
@GenerateNiceMocks([
  MockSpec<TopAnimesAnimeNetworkDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'top_animes_repository_test.mocks.dart';

class MockTolker extends Mock implements Talker {}

void main() {
  late Talker talker;

  late TopAnimesRepository repository;

  late TopAnimesAnimeNetworkDataSource networkDataSource;

  late NetworkInfo networkInfo;

  late FirebaseCrashlytics crashlytics;

  setUp(() {
    networkDataSource = MockTopAnimesAnimeNetworkDataSource();

    networkInfo = MockNetworkInfo();

    talker = MockTolker();

    repository = TopAnimesRepository(
      networkDataSource: networkDataSource,
      networkInfo: networkInfo,
      talker: talker,
    );
  });

  group('getTopAnimesWithPageNumber', () {
    const pageNumber = 1;
    final model = TopAnimesModel.fromJson(jsonDecode(dummyTopAnimesReader()));

    test('is network active', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      repository.getTopAnimesWithPageNumber(pageNumber);

      verify(networkInfo.isConnected);
    });

    group('device have connection', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(talker.handle(ServerException(), any)).thenReturn((_) => null);
      });

      test('returns AnimeGeneralModel', () async {
        when(networkDataSource.getTopAnimesWithPageNumber(pageNumber))
            .thenAnswer((_) async => model);

        final result = await repository.getTopAnimesWithPageNumber(pageNumber);

        verify(networkDataSource.getTopAnimesWithPageNumber(pageNumber));
        expect(result, Right(model));
      });
      test('returns serverFailure', () async {
        when(networkDataSource.getTopAnimesWithPageNumber(pageNumber))
            .thenThrow(ServerException());

        final result = await repository.getTopAnimesWithPageNumber(pageNumber);

        verify(networkDataSource.getTopAnimesWithPageNumber(pageNumber));
        expect(result, Left(ServerFailure()));
      });
    });

    group("device haven't connection", () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('returns NetworkFailure', () async {
        when(networkDataSource.getTopAnimesWithPageNumber(pageNumber))
            .thenAnswer((_) async => model);

        final result = await repository.getTopAnimesWithPageNumber(pageNumber);

        expect(result, Left(NetworkFailure()));
      });
    });
  });
}
