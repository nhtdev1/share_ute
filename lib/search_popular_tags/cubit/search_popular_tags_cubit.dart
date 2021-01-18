import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_ute/search/search.dart';
import 'package:search_repository/search_repository.dart';

part 'search_popular_tags_state.dart';

class SearchPopularTagsCubit extends Cubit<SearchPopularTagsState> {
  SearchPopularTagsCubit({
    this.searchCubit,
    this.searchRepository,
  }) : super(const SearchPopularTagsState()) {
    _popularTagsSubscription =
        searchRepository.popularTags.listen((popularTags) {
      emit(state.copyWith(topTags: popularTags.tags));
    });
  }

  final SearchCubit searchCubit;
  StreamSubscription<PopularTags> _popularTagsSubscription;
  final SearchRepository searchRepository;

  @override
  Future<void> close() {
    _popularTagsSubscription?.cancel();
    return super.close();
  }

  void switchViewMode() {
    if (state.viewMode == ViewMode.vertical) {
      emit(state.copyWith(viewMode: ViewMode.horizontal));
    } else {
      emit(state.copyWith(viewMode: ViewMode.vertical));
    }
  }

  void switchSearch() {
    if (state.status == SearchByPopularTagsStatus.disallowed) {
      emit(state.copyWith(status: SearchByPopularTagsStatus.allowed));
      searchCubit.changedTopTags(state.query);
    } else {
      emit(state.copyWith(status: SearchByPopularTagsStatus.disallowed));
      searchCubit.changedTopTags([]);
    }
  }

  void changedQuery(String element) {
    List<String> clone = []..addAll(state.query);
    if (clone.contains(element)) {
      clone.remove(element);
    } else {
      clone.add(element);
    }
    emit(state.copyWith(query: clone));
    if (state.status == SearchByPopularTagsStatus.allowed) {
      searchCubit.changedTopTags(clone);
    }
  }
}
