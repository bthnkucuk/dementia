import 'package:dementia/core/helpers/network_info.dart';
import 'package:dementia/features/anime_characters/data/data_sources/anime_characters_network_data_source.dart.dart';
import 'package:dementia/features/anime_characters/data/repositories/anime_characters_repository.dart';
import 'package:dementia/features/anime_characters/domain/rerpositories/anime_characters_repository.dart';
import 'package:dementia/features/anime_reviews/data/data_sources/anime_reviews_network_data_source.dart.dart';
import 'package:dementia/features/anime_reviews/data/repositories/anime_reviews_repository.dart';
import 'package:dementia/features/anime_reviews/domain/rerpositories/anime_reviews_repository.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/anime_characters/domain/usecases/get_anime_characters_with_anime_id.dart';
import 'features/anime_characters/presentation/bloc/anime_characters_bloc.dart';
import 'features/anime_reviews/domain/usecases/get_anime_reviews_with_anime_id.dart';
import 'features/anime_reviews/presentation/bloc/anime_reviews_bloc.dart';
import 'features/top_animes/data/data_sources/top_animes_network_data_source.dart.dart';
import 'features/top_animes/data/repositories/top_animes_repository.dart';
import 'features/top_animes/domain/rerpositories/top_animes_repository.dart';
import 'features/top_animes/domain/usecases/get_top_animes_with_page_number.dart';
import 'features/top_animes/presentation/bloc/top_animes_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(() => NetworkInfo());

  sl.registerLazySingleton(() => http.Client());

  // Top Animes
  sl.registerFactory(() => TopAnimesBloc(sl()));
  sl.registerLazySingleton(() => GetTopAnimesWithPageNumber(sl()));
  sl.registerLazySingleton(() => TopAnimesAnimeNetworkDataSource(client: sl()));
  sl.registerLazySingleton<ITopAnimeSRepository>(() => TopAnimesRepository(
        networkDataSource: sl(),
        networkInfo: sl(),
      ));

  // Anime Characters
  sl.registerFactory(() => AnimeCharactersBloc(sl()));
  sl.registerLazySingleton(() => GetAnimeCharactersWithAnimeId(sl()));
  sl.registerLazySingleton(
      () => AnimeCharactersNetworkDataSource(client: sl()));
  sl.registerLazySingleton<IAnimeCharactersRepository>(
      () => AnimeCharactersRepository(
            networkDataSource: sl(),
            networkInfo: sl(),
          ));

  // Anime Reviews
  sl.registerFactory(() => AnimeReviewsBloc(sl()));
  sl.registerLazySingleton(() => GetAnimeReviewsWithAnimeId(sl()));
  sl.registerLazySingleton(() => AnimeReviewsNetworkDataSource(client: sl()));
  sl.registerLazySingleton<IAnimeReviewsRepository>(
      () => AnimeReviewsRepository(
            networkDataSource: sl(),
            networkInfo: sl(),
          ));
}
