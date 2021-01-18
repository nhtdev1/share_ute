part of 'search_cubit.dart';

enum SearchStatus {
  unknown,
  fetchedPosts,
  unlockedPremium,
}

enum SearchProgress {
  unknown,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

enum PremiumSearchStatus {
  enabled,
  disabled,
}

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.typeOption = FilterOptions.unknown,
    this.dateOption = FilterOptions.unknown,
    this.topTags = const [],
    this.featureTags = const [],
    this.ownerTags = const [],
    this.posts = const [],
    this.results = const [],
    this.trackFilters = const [],
    this.status = SearchStatus.unknown,
    this.searchProgress = SearchProgress.unknown,
    this.isPremium = false,
  });

  final String query;

  final FilterOptions typeOption;
  final FilterOptions dateOption;

  final List<String> topTags;
  final List<String> featureTags;
  final List<String> ownerTags;

  final List<Post> posts;
  final List<Post> results;
  final List<TrackFilter> trackFilters;
  final SearchStatus status;
  final SearchProgress searchProgress;
  final bool isPremium;

  SearchState copyWith({
    String query,
    FilterOptions typeOption,
    FilterOptions dateOption,
    List<String> topTags,
    List<String> featureTags,
    List<String> ownerTags,
    List<Post> posts,
    List<Post> results,
    List<TrackFilter> trackFilters,
    SearchStatus status,
    SearchProgress searchProgress,
    bool isPremium,
  }) {
    return SearchState(
      query: query ?? this.query,
      typeOption: typeOption ?? this.typeOption,
      dateOption: dateOption ?? this.dateOption,
      topTags: topTags ?? this.topTags,
      featureTags: featureTags ?? this.featureTags,
      ownerTags: ownerTags ?? this.ownerTags,
      posts: posts ?? this.posts,
      results: results ?? this.results,
      trackFilters: trackFilters ?? this.trackFilters,
      status: status ?? this.status,
      searchProgress: searchProgress ?? this.searchProgress,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  @override
  List<Object> get props => [
        query,
        typeOption,
        dateOption,
        topTags,
        featureTags,
        ownerTags,
        posts,
        results,
        trackFilters,
        status,
        searchProgress,
        isPremium,
      ];
}
