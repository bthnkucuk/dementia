import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/anime_characters_bloc.dart';
import '../widgets/character_widget.dart';

class AnimeCharactersScreen extends StatelessWidget {
  final int malId;
  const AnimeCharactersScreen({
    super.key,
    required this.malId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: BlocBuilder<AnimeCharactersBloc, AnimeCharactersState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (characters) => GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.5,
                crossAxisCount: 4,
              ),
              itemCount: characters.data.length,
              itemBuilder: (BuildContext context, int index) {
                final character = characters.data[index].character;
                return CharacterWidget(character: character);
              },
            ),
            //NOT: No need loading and error state because if there is no review, [AnimeCharactersScreen] will not be called
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }
}
