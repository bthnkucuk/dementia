import 'package:bloc/bloc.dart';
import 'package:dementia/config/log/talker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'anime_app.dart';
import 'core/flavor/flavor_model.dart';
import 'injection_container.dart' as injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // talkerBloc observer
  Bloc.observer = TalkerBlocObserver(
    settings: TalkerBlocLoggerSettings(
      enabled: true,
      printChanges: false,
      printClosings: true,
      printCreations: true,
      printEvents: true,
      printTransitions: true,
      printStateFullData: false,
    ),
  );

  const flavor = FlavorModel(
    flavorType: FlavorType.DEVELOPMENT,
    name: 'Dementia Development',
  );
  await injection.init();

  talker.good('Dementia running in ${flavor.flavorType} mode.');
  runApp(const AnimeApp(
    flavor: flavor,
  ));
}
