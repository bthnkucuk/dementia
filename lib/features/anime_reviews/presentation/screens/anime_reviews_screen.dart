import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/bordered_card.dart';
import '../bloc/anime_reviews_bloc.dart';

class AnimeReviewsScreen extends StatelessWidget {
  final int malId;
  const AnimeReviewsScreen({super.key, required this.malId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: BlocBuilder<AnimeReviewsBloc, AnimeReviewsState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (reviews) => ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: reviews.data.length,
              itemBuilder: (BuildContext context, int index) {
                final review = reviews.data[index];
                return BorderedCard(
                    avatarUrl: review.user.images.values.first.imageUrl,
                    title: review.user.username,
                    textTitle: review.tags.first,
                    textMaxLines: 10,
                    text: review.review ?? '');
              },
            ),
            //NOT: No need loading and error state because if there is no review, [AnimeReviewsScreen] will not be called
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }
}
