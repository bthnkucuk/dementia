import 'package:flutter/material.dart';
import 'anime_app.dart';
import 'core/flavor/flavor_model.dart';
import 'injection_container.dart' as injection;

void main() async {
  const flavor = FlavorModel(
    flavorType: FlavorType.STAGING,
    name: 'Dementia Staging',
  );
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  runApp(const AnimeApp(
    flavor: flavor,
  ));
}
