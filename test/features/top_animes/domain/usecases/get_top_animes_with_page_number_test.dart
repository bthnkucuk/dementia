import 'dart:convert';
import 'package:dementia/features/top_animes/data/models/top_animes/top_animes_model.dart';
import 'package:dementia/features/top_animes/domain/rerpositories/top_animes_repository.dart';
import 'package:dementia/features/top_animes/domain/usecases/get_top_animes_with_page_number.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../dummy_data/top_animes/reader.dart';
@GenerateNiceMocks([MockSpec<ITopAnimeSRepository>()])
import 'get_top_animes_with_page_number_test.mocks.dart';

void main() {
  late GetTopAnimesWithPageNumber usecase;
  late MockITopAnimeSRepository mockAnimeRepository;

  setUp(() {
    mockAnimeRepository = MockITopAnimeSRepository();
    usecase = GetTopAnimesWithPageNumber(mockAnimeRepository);
  });

  const pageNumber = 1;
  final model = TopAnimesModel.fromJson(
      jsonDecode(dummyTopAnimesReader()) as Map<String, dynamic>);

  test('get AnimeCharactersModel from repository', () async {
    when(mockAnimeRepository.getTopAnimesWithPageNumber(any))
        .thenAnswer((_) async => Right(model));

    final result = await usecase(pageNumber);
    expect(result, Right(model));
    verify(mockAnimeRepository.getTopAnimesWithPageNumber(pageNumber));
    verifyNoMoreInteractions(mockAnimeRepository);
  });
}
