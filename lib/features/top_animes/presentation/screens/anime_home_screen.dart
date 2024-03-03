import 'package:dementia/core/enums/anime_type.dart';
import 'package:dementia/core/widgets/app_circular_progres_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/method_channel/method_channel_handler.dart';
import '../../../../core/widgets/top_to_reload.dart';
import '../bloc/top_animes_bloc.dart';
import '../widgets/anime_card_widget.dart';
import '../widgets/home_filter_bar.dart';

class AnimeHomeScreen extends HookWidget {
  const AnimeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final selectedTypeFilter = useState<AnimeType?>(null);

    final methodChannelHandler = MethodChannelHandler(context);

    void loadNextPage() {
      methodChannelHandler
          .triggerNativeMethod(MethodChannelMethods.topAnimesNextPage);
    }

    void filterPage(AnimeType? type) {
      methodChannelHandler.triggerNativeMethod(
        MethodChannelMethods.topAnimesFilter,
        arg: type?.underScoreString,
      );
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.addListener(() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            loadNextPage();
          }
        });
      });
      return null;
    }, []);

    useEffect(() {
      methodChannelHandler.triggerNativeMethod(
        MethodChannelMethods.topAnimesFilter,
        arg: selectedTypeFilter.value?.underScoreString,
      );

      return;
    }, [selectedTypeFilter.value]);

    return Scaffold(
      key: const Key('animeHomeScreenKey'),
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: Column(
        children: [
          HomeFilterBar(
              selectedTypeFilter: selectedTypeFilter.value,
              onChanged: (value) {
                selectedTypeFilter.value = value;
              }),
          Expanded(
            child: BlocBuilder<TopAnimesBloc, TopAnimesState>(
              builder: (context, state) {
                if ((state is TopAnimesLoadingPage ||
                    state is TopAnimesInitial)) {
                  return const Center(
                    child: AppCircularProgressIndicator.line(),
                  );
                } else if (state is TopAnimesErrorPage) {
                  return Center(
                    child: TopToReload.center(
                      onTap: () => filterPage(selectedTypeFilter.value),
                    ),
                  );
                } else {
                  //NOT: if first load compleated
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          controller: scrollController,
                          itemCount: state.singleAnimeGeneralInfoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final anime = state.singleAnimeGeneralInfoList
                                .elementAt(index);
                            if (index <
                                state.singleAnimeGeneralInfoList.length - 1) {
                              return AnimeCardWidget(anime: anime);
                            } else {
                              return Column(
                                children: [
                                  AnimeCardWidget(anime: anime),
                                  if (state is TopAnimesErrorMore)
                                    TopToReload.bottom(
                                        onTap: () => loadNextPage())
                                  else
                                    const Center(
                                        child:
                                            AppCircularProgressIndicator.dots())
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
