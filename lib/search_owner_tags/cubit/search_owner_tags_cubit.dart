import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_ute/search/search.dart';

part 'search_owner_tags_state.dart';

class SearchOwnerTagsCubit extends Cubit<SearchOwnerTagsState> {
  SearchOwnerTagsCubit({this.searchCubit})
      : super(const SearchOwnerTagsState());

  final SearchCubit searchCubit;
  void switchViewMode() {
    if (state.viewMode == ViewMode.vertical) {
      emit(state.copyWith(viewMode: ViewMode.horizontal));
    } else {
      emit(state.copyWith(viewMode: ViewMode.vertical));
    }
  }

  void removeTag(String element) {
    List<String> clone = []..addAll(state.query);
    clone.remove(element);
    emit(state.copyWith(query: clone));
  }

  void switchSearch() {
    if (state.status == SearchByOwnerTagsStatus.disallowed) {
      emit(state.copyWith(status: SearchByOwnerTagsStatus.allowed));
      searchCubit.changedOwnerTags(state.query);
    } else {
      emit(state.copyWith(status: SearchByOwnerTagsStatus.disallowed));
      searchCubit.changedOwnerTags([]);
    }
  }

  void changedTags(String element) {
    if (element.length > 20) element = element.substring(0, 20);
    List<String> clone = []..addAll(state.query);
    clone.add(element);
    emit(state.copyWith(query: clone));
    if (state.status == SearchByOwnerTagsStatus.allowed) {
      searchCubit.changedOwnerTags(clone);
    }
  }
}
