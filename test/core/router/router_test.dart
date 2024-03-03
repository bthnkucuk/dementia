import 'dart:convert';
import 'package:dementia/config/router/router.dart';
import 'package:dementia/config/router/routes.dart';
import 'package:dementia/features/anime_characters/data/models/anime_characters/anime_characters_model.dart';
import 'package:dementia/features/anime_characters/domain/usecases/get_anime_characters_with_anime_id.dart';
import 'package:dementia/features/anime_characters/presentation/bloc/anime_characters_bloc.dart';
import 'package:dementia/features/anime_reviews/data/models/anime_reviews/anime_reviews_model.dart';
import 'package:dementia/features/anime_reviews/domain/usecases/get_anime_reviews_with_anime_id.dart';
import 'package:dementia/features/anime_reviews/presentation/bloc/anime_reviews_bloc.dart';
import 'package:dementia/features/top_animes/data/models/top_animes/top_animes_model.dart';
import 'package:dementia/features/top_animes/domain/usecases/get_top_animes_with_page_number.dart';
import 'package:dementia/features/top_animes/presentation/bloc/top_animes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/anime_caracters/reader.dart';
import '../../dummy_data/top_animes/reader.dart';
import '../../dummy_data/anime_reviews/reader.dart';
@GenerateNiceMocks([
  MockSpec<GetAnimeCharactersWithAnimeId>(),
  MockSpec<GetAnimeReviewsWithAnimeId>(),
  MockSpec<GetTopAnimesWithPageNumber>(),
])
import 'router_test.mocks.dart';

void main() {
  late TopAnimesBloc animeGeneralBloc;
  late AnimeCharactersBloc animeCharactersBloc;
  late AnimeReviewsBloc animeReviewsBloc;

  late GetTopAnimesWithPageNumber getTopAnimesWithPageNumber;
  late GetAnimeReviewsWithAnimeId getAnimeReviewsWithAnimeId;
  late GetAnimeCharactersWithAnimeId getAnimeCharactersWithAnimeId;

  late TopAnimesModel animeGeneralModel;
  late AnimeCharactersModel animeCharactersModel;
  late AnimeReviewsModel animeReviewsModel;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    getTopAnimesWithPageNumber = MockGetTopAnimesWithPageNumber();
    getAnimeReviewsWithAnimeId = MockGetAnimeReviewsWithAnimeId();
    getAnimeCharactersWithAnimeId = MockGetAnimeCharactersWithAnimeId();

    animeGeneralBloc = TopAnimesBloc(getTopAnimesWithPageNumber);
    animeCharactersBloc = AnimeCharactersBloc(getAnimeCharactersWithAnimeId);
    animeReviewsBloc = AnimeReviewsBloc(getAnimeReviewsWithAnimeId);

    animeGeneralModel = TopAnimesModel.fromJson(
        jsonDecode(dummyTopAnimesReader()) as Map<String, dynamic>);
    animeCharactersModel = AnimeCharactersModel.fromJson(
        jsonDecode(dummyAnimeCharactersReader()) as Map<String, dynamic>);
    animeReviewsModel = AnimeReviewsModel.fromJson(
        jsonDecode(dummyAnimeReviewsReader()) as Map<String, dynamic>);

    when(getAnimeCharactersWithAnimeId(1))
        .thenAnswer((_) async => fp.Right(animeCharactersModel));
    when(getAnimeReviewsWithAnimeId(1))
        .thenAnswer((_) async => fp.Right(animeReviewsModel));
    when(getTopAnimesWithPageNumber(1))
        .thenAnswer((_) async => fp.Right(animeGeneralModel));

    animeCharactersBloc.add(const AnimeCharactersEvent.fetchAnimeCharacters(1));
    animeReviewsBloc.add(const AnimeReviewsEvent.fetchAnimeReviews(1));
    animeGeneralBloc.add(const TopAnimesEvent.filter());

    await Future.delayed(const Duration(milliseconds: 3000));
  });

  test('should all blocs loaded', () {
    // assert
    expect(animeCharactersBloc.state,
        equals(AnimeCharactersState.loaded(animeCharactersModel)));

    expect(animeReviewsBloc.state,
        equals(AnimeReviewsState.loaded(animeReviewsModel)));

    expect(
        animeGeneralBloc.state, equals(TopAnimesLoaded([animeGeneralModel])));
  });

  testWidgets('Test typed route navigations', (WidgetTester tester) async {
    await tester.pumpWidget(TestWidget(
      animeGeneralBloc: animeGeneralBloc,
      animeCharactersBloc: animeCharactersBloc,
      animeReviewsBloc: animeReviewsBloc,
    ));

    await tester.pump(const Duration(milliseconds: 1000));

    final scaffoldState =
        tester.firstState(find.byKey(const Key('animeHomeScreenKey')));

    await tester.pump(const Duration(milliseconds: 1000));

    const HomeRoute().go(scaffoldState.context);
    await tester.pump();
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Sousou no Frieren'), findsOneWidget);

    const DetailsRoute(1).go(scaffoldState.context);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(find.text('Sousou no Frieren'), findsOneWidget);

    const CharactersRoute(1).go(scaffoldState.context);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(find.text('Characters'), findsOneWidget);

    scaffoldState.context.pop();
    await tester.pump(const Duration(milliseconds: 1000));

    const ReviewsRoute(1).push(scaffoldState.context);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(find.text('Reviews'), findsOneWidget);
  });
}

class TestWidget extends StatelessWidget {
  final TopAnimesBloc animeGeneralBloc;
  final AnimeCharactersBloc animeCharactersBloc;
  final AnimeReviewsBloc animeReviewsBloc;

  const TestWidget({
    super.key,
    required this.animeGeneralBloc,
    required this.animeCharactersBloc,
    required this.animeReviewsBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TopAnimesBloc>(
            create: (_) => animeGeneralBloc, lazy: false),
        BlocProvider<AnimeReviewsBloc>(
            create: (_) => animeReviewsBloc, lazy: false),
        BlocProvider<AnimeCharactersBloc>(
            create: (_) => animeCharactersBloc, lazy: false),
      ],
      child: MaterialApp.router(
        title: 'Material App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.amber.shade500,
            titleTextStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            elevation: 2,
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
