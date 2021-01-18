part of 'search_popular_tags_cubit.dart';

enum SearchByPopularTagsStatus {
  disallowed,
  allowed,
}

enum ViewMode {
  horizontal,
  vertical,
}

class SearchPopularTagsState extends Equatable {
  const SearchPopularTagsState({
    this.query = const [],
    this.topTags = const [],
    this.viewMode = ViewMode.horizontal,
    this.status = SearchByPopularTagsStatus.disallowed,
  });

  final List<String> query;
  final List<String> topTags;
  final ViewMode viewMode;
  final SearchByPopularTagsStatus status;

  SearchPopularTagsState copyWith({
    List<String> query,
    List<String> topTags,
    ViewMode viewMode,
    SearchByPopularTagsStatus status,
  }) {
    return SearchPopularTagsState(
      query: query ?? this.query,
      topTags: topTags ?? this.topTags,
      viewMode: viewMode ?? this.viewMode,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [query, topTags, viewMode, status];
}
