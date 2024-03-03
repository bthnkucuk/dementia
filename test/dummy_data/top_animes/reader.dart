import 'dart:io';

String dummyTopAnimesReader() =>
    File('test/dummy_data/top_animes/top_animes.json').readAsStringSync();
