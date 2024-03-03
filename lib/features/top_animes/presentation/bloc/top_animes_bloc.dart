// ignore_for_file: library_private_types_in_public_api

import 'package:dementia/core/enums/anime_type.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/helpers/failure_to_message.dart';
import '../../data/models/top_animes/top_animes_model.dart';
import '../../domain/usecases/get_top_animes_with_page_number.dart';
part 'top_anime_event.dart';
part 'top_animes_state.dart';
part 'top_animes_bloc.freezed.dart';

class TopAnimesBloc extends Bloc<TopAnimesEvent, TopAnimesState> {
  final GetTopAnimesWithPageNumber getTopAnimesWithPageNumber;

  TopAnimesBloc(this.getTopAnimesWithPageNumber)
      : super(const TopAnimesInitial([])) {
    on<TopAnimesEventFilter>(onfilter);
    on<TopAnimesEventNextPage>(onNextPage);
  }

  Future<void> onfilter(
    TopAnimesEventFilter event,
    Emitter<TopAnimesState> emit,
  ) async {
    emit(TopAnimesLoadingPage(const [], filterType: event.filterType));
    final result = await getTopAnimesWithPageNumber(1,
        type: event.filterType?.underScoreString);
    result.fold(
      (l) => emit(TopAnimesErrorPage(
          failureToMessage(l), state.topAnimesModelList,
          filterType: event.filterType)),
      (r) => emit(
        TopAnimesLoaded([r], filterType: event.filterType),
      ),
    );
  }

  Future<void> onNextPage(
    TopAnimesEventNextPage event,
    Emitter<TopAnimesState> emit,
  ) async {
    final hasNextPage = state.topAnimesModelList.isNotEmpty &&
        state.topAnimesModelList.last.pagination.hasNextPage;

    if (state.runtimeType != TopAnimesLoaded && !hasNextPage) {
      return;
    }

    final nextPage = state.topAnimesModelList.last.pagination.currentPage + 1;

    emit(TopAnimesLoadingMore(state.topAnimesModelList,
        filterType: state.filterType));
    final result = await getTopAnimesWithPageNumber(nextPage,
        type: state.filterType?.underScoreString);
    result.fold(
      (l) => emit(TopAnimesErrorMore(
          failureToMessage(l), state.topAnimesModelList,
          filterType: state.filterType)),
      (r) => emit(
        TopAnimesLoaded(state.topAnimesModelList + [r],
            filterType: state.filterType),
      ),
    );
  }
}
