part of 'search_owner_tags_cubit.dart';

enum SearchByOwnerTagsStatus {
  disallowed,
  allowed,
}

enum ViewMode {
  horizontal,
  vertical,
}

class SearchOwnerTagsState extends Equatable {
  const SearchOwnerTagsState({
    this.query = const [],
    this.viewMode = ViewMode.horizontal,
    this.status = SearchByOwnerTagsStatus.disallowed,
  });

  final List<String> query;
  final ViewMode viewMode;
  final SearchByOwnerTagsStatus status;

  SearchOwnerTagsState copyWith({
    List<String> query,
    ViewMode viewMode,
    SearchByOwnerTagsStatus status,
  }) {
    return SearchOwnerTagsState(
      query: query ?? this.query,
      viewMode: viewMode ?? this.viewMode,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [query, viewMode, status];
}
