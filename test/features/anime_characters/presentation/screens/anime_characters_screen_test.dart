// ignore_for_file: unused_element

import 'dart:convert';

import 'package:dementia/features/anime_characters/data/models/anime_characters/anime_characters_model.dart';
import 'package:dementia/features/anime_characters/domain/usecases/get_anime_characters_with_anime_id.dart';
import 'package:dementia/features/anime_characters/presentation/bloc/anime_characters_bloc.dart';
import 'package:dementia/features/anime_characters/presentation/screens/anime_characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart' as fp;

import '../../../../dummy_data/anime_caracters/reader.dart';
@GenerateNiceMocks([
  MockSpec<GetAnimeCharactersWithAnimeId>(),
])
import 'anime_characters_screen_test.mocks.dart';

void main() {
  late AnimeCharactersBloc animeCharactersBloc;
  late GetAnimeCharactersWithAnimeId getAnimeCharactersWithAnimeId;
  late AnimeCharactersModel animeCharactersModel;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();

    getAnimeCharactersWithAnimeId = MockGetAnimeCharactersWithAnimeId();
    animeCharactersBloc = AnimeCharactersBloc(getAnimeCharactersWithAnimeId);

    animeCharactersModel = AnimeCharactersModel.fromJson(
        jsonDecode(dummyAnimeCharactersReader()) as Map<String, dynamic>);

    when(getAnimeCharactersWithAnimeId(1))
        .thenAnswer((_) async => fp.Right(animeCharactersModel));

    animeCharactersBloc.add(const AnimeCharactersEvent.fetchAnimeCharacters(1));

    await Future.delayed(const Duration(milliseconds: 3000));
  });

  testWidgets('anime characters screen', (widgetTester) async {
    await widgetTester.pumpWidget(_WidgetUnderTest(
      animeCharactersBloc: animeCharactersBloc,
    ));

    await widgetTester.pump(const Duration(milliseconds: 300));

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Characters'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}

class _WidgetUnderTest extends StatelessWidget {
  final AnimeCharactersBloc animeCharactersBloc;
  const _WidgetUnderTest({
    super.key,
    required this.animeCharactersBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => animeCharactersBloc),
      ],
      child: AnimeCharactersScreen(malId: 1),
    ));
  }
}
