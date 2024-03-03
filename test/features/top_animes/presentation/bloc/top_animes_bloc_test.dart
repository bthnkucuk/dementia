import 'dart:convert';

import 'package:dementia/core/failures/failures.dart';
import 'package:dementia/core/helpers/failure_to_message.dart';
import 'package:dementia/features/top_animes/data/models/top_animes/top_animes_model.dart';
import 'package:dementia/features/top_animes/domain/usecases/get_top_animes_with_page_number.dart';
import 'package:dementia/features/top_animes/presentation/bloc/top_animes_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/top_animes/reader.dart';
@GenerateNiceMocks([MockSpec<GetTopAnimesWithPageNumber>()])
import 'top_animes_bloc_test.mocks.dart';

void main() {
  const pageNumber = 1;

  late TopAnimesBloc bloc;
  late GetTopAnimesWithPageNumber getTopAnimesWithPageNumber;
  late TopAnimesModel model;

  setUp(() async {
    getTopAnimesWithPageNumber = MockGetTopAnimesWithPageNumber();
    bloc = TopAnimesBloc(getTopAnimesWithPageNumber);
    model = TopAnimesModel.fromJson(
        jsonDecode(dummyTopAnimesReader()) as Map<String, dynamic>);
  });

  test('initial state should be AnimeGeneralInitial', () {
    // assert
    expect(bloc.state, equals(const TopAnimesInitial([])));
  });

  blocTest<TopAnimesBloc, TopAnimesState>(
    'emits [_AnimeGeneralEventFilter] when AnimeGeneralEvent.filter() is added. If successfull, then adds model to state',
    build: () {
      when(getTopAnimesWithPageNumber(pageNumber))
          .thenAnswer((_) async => Right(model));

      return bloc;
    },
    act: (bloc) => bloc.add(const TopAnimesEvent.filter()),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      const TopAnimesLoadingPage([]),
      TopAnimesLoaded([model]),
    ],
  );

  blocTest<TopAnimesBloc, TopAnimesState>(
    'emits [_AnimeGeneralEventFilter] when AnimeGeneralEvent.filter() is added. If unsuccessfull, then adds error to state',
    build: () {
      when(getTopAnimesWithPageNumber(pageNumber))
          .thenAnswer((_) async => Left(NetworkFailure()));
      return bloc;
    },
    act: (bloc) => bloc.add(const TopAnimesEvent.filter()),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      const TopAnimesLoadingPage([]),
      TopAnimesErrorPage(failureToMessage(NetworkFailure()), const []),
    ],
  );
}
