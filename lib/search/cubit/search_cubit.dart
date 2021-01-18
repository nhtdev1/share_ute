import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/search/search.dart';
import 'package:tiengviet/tiengviet.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  bool get isReadyForSearch {
    if (state.typeOption != FilterOptions.unknown) return true;
    if (state.dateOption != FilterOptions.unknown) return true;
    if (state.topTags.isNotEmpty) return true;
    if (state.featureTags.isNotEmpty) return true;
    if (state.ownerTags.isNotEmpty) return true;
    return false;
  }

  void clear() {
    emit(state.copyWith(
      results: const [],
      trackFilters: const [],
      query: '',
      typeOption: FilterOptions.unknown,
      dateOption: FilterOptions.unknown,
      topTags: const [],
      featureTags: const [],
      ownerTags: const [],
      searchProgress: SearchProgress.unknown,
    ));
  }

  void fetchedPosts(List<Post> posts) {
    emit(state.copyWith(
      posts: posts,
      status: SearchStatus.fetchedPosts,
      query: '',
      typeOption: FilterOptions.unknown,
      dateOption: FilterOptions.unknown,
      topTags: const [],
      featureTags: const [],
      ownerTags: const [],
      results: const [],
      trackFilters: const [],
      searchProgress: SearchProgress.unknown,
    ));
  }

  void changedTopTags(List<String> tags) {
    emit(state.copyWith(topTags: tags));
  }

  void changedFeatureTags(List<String> tags) {
    emit(state.copyWith(featureTags: tags));
  }

  void changedOwnerTags(List<String> tags) {
    emit(state.copyWith(ownerTags: tags));
  }

  void changedOptions(FilterOptions option) {
    if (option.toString().contains('File')) {
      if (state.typeOption == option) {
        emit(state.copyWith(typeOption: FilterOptions.unknown));
      } else {
        emit(state.copyWith(typeOption: option));
      }
    } else {
      if (state.dateOption == option) {
        emit(state.copyWith(dateOption: FilterOptions.unknown));
      } else {
        emit(state.copyWith(dateOption: option));
      }
    }
  }

  void getResults(String query) async {
    emit(state.copyWith(searchProgress: SearchProgress.submissionInProgress));
    try {
      final results = await filterPostsByQuery(query);
      emit(state.copyWith(
        results: results,
        searchProgress: SearchProgress.submissionSuccess,
      ));
    } on Exception {
      emit(state.copyWith(searchProgress: SearchProgress.submissionFailure));
    }
  }

  Future<List<Post>> filterPostsByQuery(String query) async {
    List<Post> results = [];
    results = state.posts
        .where((p) => p.postTitle.toLowerCase().contains(
              query.toLowerCase(),
            ))
        .toList();
    if (results.isEmpty)
      results = []..addAll(state.posts
          .where((p) => _isApproximateString(
                TiengViet.parse(query).toLowerCase(),
                p.postTitle.toLowerCase(),
              ))
          .toList());

    // Track Filter Record
    List<TrackFilter> trackFilters = [];
    trackFilters.add(TrackFilter(
      option: FilterOptions.byStringQuery,
      optionValues: []..add(query),
      result: results,
    ));

    if (state.typeOption != FilterOptions.unknown) {
      results = _filterPostsByType(results);
      trackFilters.add(TrackFilter(
        option: state.typeOption,
        optionValues: []..add(state.typeOption == FilterOptions.byPdfFile
            ? 'pdf'
            : state.typeOption == FilterOptions.byDocFile
                ? 'doc'
                : state.typeOption == FilterOptions.byXlsFile
                    ? 'xls'
                    : 'ppt'),
        result: results,
      ));
    }

    if (state.dateOption != FilterOptions.unknown) {
      results = _filterPostsByDate(results);
      trackFilters.add(TrackFilter(
        option: state.dateOption,
        optionValues: []..add(
            state.dateOption == FilterOptions.byDateCreatedToday
                ? 'Hôm nay'
                : state.typeOption == FilterOptions.byDateCreatedYesterday
                    ? 'Hôm qua'
                    : state.typeOption == FilterOptions.byDateCreatedWeek
                        ? 'Tuần qua'
                        : state.typeOption == FilterOptions.byDateCreatedMonth
                            ? 'Tháng qua'
                            : '3 tháng qua',
          ),
        result: results,
      ));
    }

    if (state.topTags.isNotEmpty) {
      results = _filterPostsByTopTags(results);
      trackFilters.add(TrackFilter(
        option: FilterOptions.byTopTags,
        optionValues: state.topTags,
        result: results,
      ));
    }

    if (state.featureTags.isNotEmpty) {
      results = _filterPostsByFeatureTags(results);
      trackFilters.add(TrackFilter(
        option: FilterOptions.byFeatureTags,
        optionValues: state.featureTags,
        result: results,
      ));
    }

    if (state.ownerTags.isNotEmpty) {
      results = _filterPostsByOwnerTags(results);
      trackFilters.add(TrackFilter(
        option: FilterOptions.byOwnerTags,
        optionValues: state.ownerTags,
        result: results,
      ));
    }

    emit(state.copyWith(trackFilters: trackFilters));

    return results;
  }

  List<Post> _filterPostsByType(List<Post> posts) {
    List<Post> results = [];

    String query = state.typeOption == FilterOptions.byPdfFile
        ? 'pdf'
        : state.typeOption == FilterOptions.byDocFile
            ? 'doc'
            : state.typeOption == FilterOptions.byXlsFile
                ? 'xls'
                : 'ppt';

    results = posts
        .where(
            (p) => p.originalFile.fileExtension.toLowerCase().contains(query))
        .toList();

    return results;
  }

  List<Post> _filterPostsByDate(List<Post> posts) {
    List<Post> results = [];
    results = posts
        .where((p) => _isMatchDateOption(p.dateCreated, state.dateOption))
        .toList();

    return results;
  }

  List<Post> _filterPostsByTopTags(List<Post> posts) {
    List<Post> results = [];
    results = posts
        .where((p) => _isApproximateTags(state.topTags, p.postTags))
        .toList();
    return results;
  }

  List<Post> _filterPostsByFeatureTags(List<Post> posts) {
    List<Post> results = [];
    results = posts
        .where((p) => _isApproximateTags(state.featureTags, p.postTags))
        .toList();
    return results;
  }

  List<Post> _filterPostsByOwnerTags(List<Post> posts) {
    List<Post> results = [];
    results = posts
        .where((p) => _isApproximateTags(state.ownerTags, p.postTags))
        .toList();
    return results;
  }

  bool _isApproximateTags(List<String> tag1, List<String> tag2) {
    for (int i = 0; i < tag1.length; i++) {
      for (int j = 0; j < tag2.length; j++) {
        if (_isApproximateString(
          TiengViet.parse(tag1[i]).toLowerCase(),
          TiengViet.parse(tag2[j]).toLowerCase(),
        )) return true;
      }
    }
    return false;
  }

  bool _isMatchDateOption(String dateCreated, FilterOptions dateOption) {
    DateTime now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(
      int.parse(dateCreated),
    );
    final days = now.difference(date).inDays;
    if (dateOption == FilterOptions.byDateCreatedToday) {
      return days == 0;
    } else if (dateOption == FilterOptions.byDateCreatedYesterday) {
      return days == 1;
    } else if (dateOption == FilterOptions.byDateCreatedWeek) {
      return days <= 7;
    } else if (dateOption == FilterOptions.byDateCreatedMonth) {
      return days <= 31;
    } else if (dateOption == FilterOptions.byDateCreatedQuarter) {
      return days <= 92;
    }
    return false;
  }

  bool _isApproximateString(String s, String s1) {
    final bias = (s.length * 0.4).round();
    if (s1.length < (s.length - bias) || s1.length > (s.length + bias))
      return false;
    int k = 0;
    int i = 0;
    int j = 0;
    int error = 0;

    while (i < s.length && j < s1.length) {
      if (s[i] != s1[j]) {
        error++;

        for (k = 1; k <= bias; k++) {
          if ((i + k < s.length) && s[i + k] == s1[j]) {
            i += k;

            break;
          } else if ((j + k < s1.length) && s[i] == s1[j + k]) {
            j += k;

            break;
          }
        }
      }
      i++;
      j++;
    }
    error += s.length - i + s1.length - j;

    if (error <= bias)
      return true;
    else
      return false;
  }
}
