import 'dart:convert';
import 'package:dementia/features/top_animes/data/models/top_animes/top_animes_model.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../dummy_data/top_animes/reader.dart';

void main() {
  test('anime general model dummy data fromJson and isEqual tests', () async {
    final json = jsonDecode(dummyTopAnimesReader()) as Map<String, dynamic>;

    final result = TopAnimesModel.fromJson(json);
    final result2 = TopAnimesModel.fromJson(json);

    expect(result, equals(result2));
    expect(result, isA<TopAnimesModel>());
  });
}
