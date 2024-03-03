part of 'top_animes_bloc.dart';

abstract class TopAnimesState extends Equatable {
  final List<TopAnimesModel> topAnimesModelList;
  final AnimeType? filterType;

  Iterable<SingleAnimeGeneralInfo> get singleAnimeGeneralInfoList =>
      topAnimesModelList.expand((element) => element.data);
  const TopAnimesState(this.topAnimesModelList, {this.filterType});

  @override
  List<Object> get props => [topAnimesModelList];
}

class TopAnimesInitial extends TopAnimesState {
  const TopAnimesInitial(super.topAnimesModelList, {super.filterType});

  @override
  List<Object> get props => [topAnimesModelList];
}

class TopAnimesLoadingPage extends TopAnimesState {
  const TopAnimesLoadingPage(super.topAnimesModelList, {super.filterType});

  @override
  List<Object> get props => [topAnimesModelList];
}

class TopAnimesLoadingMore extends TopAnimesState {
  const TopAnimesLoadingMore(super.topAnimesModelList, {super.filterType});

  @override
  List<Object> get props => [topAnimesModelList];
}

class TopAnimesLoaded extends TopAnimesState {
  const TopAnimesLoaded(super.topAnimesModelList, {super.filterType});

  @override
  List<Object> get props => [topAnimesModelList];
}

class TopAnimesErrorPage extends TopAnimesState {
  final String message;

  const TopAnimesErrorPage(this.message, super.topAnimesModelList,
      {super.filterType});

  @override
  List<Object> get props => [message, topAnimesModelList];
}

class TopAnimesErrorMore extends TopAnimesState {
  final String message;

  const TopAnimesErrorMore(this.message, super.topAnimesModelList,
      {super.filterType});

  @override
  List<Object> get props => [message, topAnimesModelList];
}
