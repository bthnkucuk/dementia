// ignore_for_file: unused_element

import 'dart:convert';

import 'package:dementia/features/anime_characters/data/models/anime_characters/anime_characters_model.dart';
import 'package:dementia/features/anime_characters/domain/usecases/get_anime_characters_with_anime_id.dart';
import 'package:dementia/features/anime_characters/presentation/bloc/anime_characters_bloc.dart';
import 'package:dementia/features/anime_characters/presentation/screens/anime_detail/anime_detail_screen.dart';
import 'package:dementia/features/anime_reviews/data/models/anime_reviews/anime_reviews_model.dart';
import 'package:dementia/features/anime_reviews/domain/usecases/get_anime_reviews_with_anime_id.dart';
import 'package:dementia/features/anime_reviews/presentation/bloc/anime_reviews_bloc.dart';
import 'package:dementia/features/top_animes/data/models/top_animes/top_animes_model.dart';
import 'package:dementia/features/top_animes/domain/usecases/get_top_animes_with_page_number.dart';
import 'package:dementia/features/top_animes/presentation/bloc/top_animes_bloc.dart';
import 'package:dementia/features/top_animes/presentation/widgets/details_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart' as fp;

import '../../../../dummy_data/anime_caracters/reader.dart';
import '../../../../dummy_data/anime_reviews/reader.dart';
import '../../../../dummy_data/top_animes/reader.dart';
@GenerateNiceMocks([
  MockSpec<GetTopAnimesWithPageNumber>(),
  MockSpec<GetAnimeCharactersWithAnimeId>(),
  MockSpec<GetAnimeReviewsWithAnimeId>()
])
import 'anime_detail_screen_test.mocks.dart';

void main() {
  late TopAnimesBloc animeGeneralBloc;
  late GetTopAnimesWithPageNumber getTopAnimesWithPageNumber;
  late TopAnimesModel animeGeneralModel;

  late AnimeCharactersBloc animeCharactersBloc;
  late GetAnimeCharactersWithAnimeId getAnimeCharactersWithAnimeId;
  late AnimeCharactersModel animeCharactersModel;

  late AnimeReviewsBloc animeReviewsBloc;
  late GetAnimeReviewsWithAnimeId getAnimeReviewsWithAnimeId;
  late AnimeReviewsModel animeReviewsModel;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    getTopAnimesWithPageNumber = MockGetTopAnimesWithPageNumber();
    animeGeneralBloc = TopAnimesBloc(getTopAnimesWithPageNumber);

    getAnimeCharactersWithAnimeId = MockGetAnimeCharactersWithAnimeId();
    animeCharactersBloc = AnimeCharactersBloc(getAnimeCharactersWithAnimeId);

    getAnimeReviewsWithAnimeId = MockGetAnimeReviewsWithAnimeId();
    animeReviewsBloc = AnimeReviewsBloc(getAnimeReviewsWithAnimeId);

    animeGeneralModel = TopAnimesModel.fromJson(
        jsonDecode(dummyTopAnimesReader()) as Map<String, dynamic>);

    animeCharactersModel = AnimeCharactersModel.fromJson(
        jsonDecode(dummyAnimeCharactersReader()) as Map<String, dynamic>);

    animeReviewsModel = AnimeReviewsModel.fromJson(
        jsonDecode(dummyAnimeReviewsReader()) as Map<String, dynamic>);

    when(getTopAnimesWithPageNumber(1))
        .thenAnswer((_) async => fp.Right(animeGeneralModel));

    when(getAnimeCharactersWithAnimeId(1))
        .thenAnswer((_) async => fp.Right(animeCharactersModel));

    when(getAnimeReviewsWithAnimeId(1))
        .thenAnswer((_) async => fp.Right(animeReviewsModel));

    animeGeneralBloc.add(const TopAnimesEvent.filter());

    animeCharactersBloc.add(const AnimeCharactersEvent.fetchAnimeCharacters(1));

    animeReviewsBloc.add(const AnimeReviewsEvent.fetchAnimeReviews(1));

    await Future.delayed(const Duration(milliseconds: 3000));
  });

  testWidgets('anime details screen', (widgetTester) async {
    await widgetTester.pumpWidget(_WidgetUnderTest(
      topAnimesBloc: animeGeneralBloc,
      animeCharactersBloc: animeCharactersBloc,
      animeReviewsBloc: animeReviewsBloc,
    ));

    await widgetTester.pump(const Duration(milliseconds: 300));

    expect(find.text('Synopsis'), findsOneWidget);
    expect(find.text('YouTube'), findsOneWidget);
    expect(find.byType(DetailsAppBar), findsOneWidget);
  });
}

class _WidgetUnderTest extends StatelessWidget {
  final TopAnimesBloc topAnimesBloc;
  final AnimeCharactersBloc animeCharactersBloc;
  final AnimeReviewsBloc animeReviewsBloc;
  const _WidgetUnderTest(
      {super.key,
      required this.topAnimesBloc,
      required this.animeCharactersBloc,
      required this.animeReviewsBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => topAnimesBloc),
        BlocProvider(create: (context) => animeCharactersBloc),
        BlocProvider(create: (context) => animeReviewsBloc)
      ],
      child: AnimeDetailsScreen(malId: 1),
    ));
  }
}
