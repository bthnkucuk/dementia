// ignore_for_file: unused_element

import 'dart:convert';

import 'package:dementia/features/anime_reviews/data/models/anime_reviews/anime_reviews_model.dart';
import 'package:dementia/features/anime_reviews/domain/usecases/get_anime_reviews_with_anime_id.dart';
import 'package:dementia/features/anime_reviews/presentation/bloc/anime_reviews_bloc.dart';
import 'package:dementia/features/anime_reviews/presentation/screens/anime_reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart' as fp;

import '../../../../../dummy_data/anime_reviews/reader.dart';
@GenerateNiceMocks([
  MockSpec<GetAnimeReviewsWithAnimeId>(),
])
import 'anime_reviews_screen_test.mocks.dart';

void main() {
  late AnimeReviewsBloc animeReviewsBloc;
  late GetAnimeReviewsWithAnimeId getAnimeReviewsWithAnimeId;
  late AnimeReviewsModel animeReviewsModel;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();

    getAnimeReviewsWithAnimeId = MockGetAnimeReviewsWithAnimeId();
    animeReviewsBloc = AnimeReviewsBloc(getAnimeReviewsWithAnimeId);

    animeReviewsModel = AnimeReviewsModel.fromJson(
        jsonDecode(dummyAnimeReviewsReader()) as Map<String, dynamic>);

    when(getAnimeReviewsWithAnimeId(1))
        .thenAnswer((_) async => fp.Right(animeReviewsModel));

    animeReviewsBloc.add(const AnimeReviewsEvent.fetchAnimeReviews(1));

    await Future.delayed(const Duration(milliseconds: 3000));
  });

  testWidgets('anime reviews screen', (widgetTester) async {
    await widgetTester.pumpWidget(_WidgetUnderTest(
      animeReviewsBloc: animeReviewsBloc,
    ));

    await widgetTester.pump(const Duration(milliseconds: 300));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Reviews'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}

class _WidgetUnderTest extends StatelessWidget {
  final AnimeReviewsBloc animeReviewsBloc;
  const _WidgetUnderTest({
    super.key,
    required this.animeReviewsBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => animeReviewsBloc),
      ],
      child: AnimeReviewsScreen(malId: 1),
    ));
  }
}
