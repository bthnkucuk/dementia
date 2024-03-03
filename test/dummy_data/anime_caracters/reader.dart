import 'dart:io';

String dummyAnimeCharactersReader() =>
    File('test/dummy_data/anime_caracters/anime_caracters.json')
        .readAsStringSync();
