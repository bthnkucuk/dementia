// ignore_for_file: unused_element

import 'dart:convert';

import 'package:dementia/features/top_animes/data/models/top_animes/top_animes_model.dart';
import 'package:dementia/features/top_animes/domain/usecases/get_top_animes_with_page_number.dart';
import 'package:dementia/features/top_animes/presentation/bloc/top_animes_bloc.dart';
import 'package:dementia/features/top_animes/presentation/screens/anime_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:fpdart/fpdart.dart' as fp;

import '../../../../dummy_data/top_animes/reader.dart';
@GenerateNiceMocks([
  MockSpec<GetTopAnimesWithPageNumber>(),
])
import 'anime_home_screen_test.mocks.dart';

void main() {
  late TopAnimesBloc animeGeneralBloc;
  late GetTopAnimesWithPageNumber getTopAnimesWithPageNumber;
  late TopAnimesModel animeGeneralModel;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    getTopAnimesWithPageNumber = MockGetTopAnimesWithPageNumber();
    animeGeneralBloc = TopAnimesBloc(getTopAnimesWithPageNumber);

    animeGeneralModel = TopAnimesModel.fromJson(
        jsonDecode(dummyTopAnimesReader()) as Map<String, dynamic>);

    when(getTopAnimesWithPageNumber(1))
        .thenAnswer((_) async => fp.Right(animeGeneralModel));

    animeGeneralBloc.add(const TopAnimesEvent.filter());

    await Future.delayed(const Duration(milliseconds: 3000));
  });

  testWidgets('anime home screen', (widgetTester) async {
    await widgetTester.pumpWidget(_WidgetUnderTest(
      topAnimesBloc: animeGeneralBloc,
    ));

    await widgetTester.pump(const Duration(milliseconds: 300));
    expect(find.text('Discover'), findsOneWidget);
    expect(find.byType(AnimeHomeScreen), findsOneWidget);
  });
}

class _WidgetUnderTest extends StatelessWidget {
  final TopAnimesBloc topAnimesBloc;
  const _WidgetUnderTest({super.key, required this.topAnimesBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => topAnimesBloc,
        ),
      ],
      child: const AnimeHomeScreen(),
    ));
  }
}
