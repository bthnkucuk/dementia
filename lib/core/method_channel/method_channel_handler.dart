import 'package:dementia/core/enums/anime_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/anime_characters/presentation/bloc/anime_characters_bloc.dart';
import '../../features/anime_reviews/presentation/bloc/anime_reviews_bloc.dart';
import '../../features/top_animes/presentation/bloc/top_animes_bloc.dart';

class MethodChannelHandler {
  final BuildContext context;
  final methodChannel = const MethodChannel('com.example.bloc_event_sender');

  MethodChannelHandler(this.context) {
    methodChannel.setMethodCallHandler(_handleMethod);
  }

  void triggerNativeMethod(MethodChannelMethods method, {dynamic arg}) async {
    methodChannel.invokeMethod(method.methodValue, arg);
  }

  Future _handleMethod(MethodCall call) async {
    print(call);
    switch (MethodChannelMethods.fromString(call.method)) {
      //top animes
      case MethodChannelMethods.topAnimesNextPage:
        BlocProvider.of<TopAnimesBloc>(context)
            .add(const TopAnimesEvent.nextPage());
        break;
      case MethodChannelMethods.topAnimesFilter:
        BlocProvider.of<TopAnimesBloc>(context)
            .add(TopAnimesEvent.filter(AnimeType.fromString(call.arguments)));
        break;

      //anime characters
      case MethodChannelMethods.fetchAnimeCharacters:
        BlocProvider.of<AnimeCharactersBloc>(context)
            .add(AnimeCharactersEvent.fetchAnimeCharacters(call.arguments));
        break;

      //anime reviews
      case MethodChannelMethods.fetchAnimeReviews:
        BlocProvider.of<AnimeReviewsBloc>(context)
            .add(AnimeReviewsEvent.fetchAnimeReviews(call.arguments));
        break;
    }
  }
}

enum MethodChannelMethods {
  //anime general
  topAnimesNextPage,
  topAnimesFilter,

  //anime characters
  fetchAnimeCharacters,

  //anime reviews
  fetchAnimeReviews,
  ;

  String get methodValue {
    switch (this) {
      //anime general
      case topAnimesNextPage:
        return 'top_animes_next_page';
      case topAnimesFilter:
        return 'top_animes_filter';

      //anime characters
      case fetchAnimeCharacters:
        return 'fetch_anime_characters';

      //anime reviews
      case fetchAnimeReviews:
        return 'fetch_anime_reviews';
    }
  }

  static MethodChannelMethods fromString(String method) {
    switch (method) {
      //anime general
      case 'top_animes_next_page':
        return topAnimesNextPage;
      case 'top_animes_filter':
        return topAnimesFilter;

      //anime characters
      case 'fetch_anime_characters':
        return fetchAnimeCharacters;

      //anime reviews
      case 'fetch_anime_reviews':
        return fetchAnimeReviews;

      default:
        throw Exception('Method not found');
    }
  }
}
