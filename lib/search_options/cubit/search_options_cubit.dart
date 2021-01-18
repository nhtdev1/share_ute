import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_ute/search/search.dart';
import 'package:search_repository/search_repository.dart';

part 'search_options_state.dart';

class SearchOptionsCubit extends Cubit<SearchOptionsState> {
  SearchOptionsCubit({
    this.searchCubit,
    this.searchRepository,
  }) : super(const SearchOptionsState()) {
    _featureTagsSubscription =
        searchRepository.featureTags.listen((featureTags) {
      emit(state.copyWith(options: featureTags.tags));
    });
  }
  final SearchCubit searchCubit;

  StreamSubscription<FeatureTags> _featureTagsSubscription;
  final SearchRepository searchRepository;

  @override
  Future<void> close() {
    _featureTagsSubscription?.cancel();
    return super.close();
  }

  void switchSearch() {
    if (state.status == SearchByOptionsStatus.disallowed) {
      emit(state.copyWith(status: SearchByOptionsStatus.allowed));
      searchCubit.changedFeatureTags(state.query);
    } else {
      emit(state.copyWith(status: SearchByOptionsStatus.disallowed));
      searchCubit.changedFeatureTags([]);
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
    if (state.status == SearchByOptionsStatus.allowed) {
      searchCubit.changedFeatureTags(clone);
    }
  }
}
