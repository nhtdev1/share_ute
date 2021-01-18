part of 'search_options_cubit.dart';

enum SearchByOptionsStatus {
  disallowed,
  allowed,
}

class SearchOptionsState extends Equatable {
  const SearchOptionsState({
    this.query = const [],
    this.options = const [],
    this.status = SearchByOptionsStatus.disallowed,
  });
  final List<String> query;

  final List<String> options;

  final SearchByOptionsStatus status;

  SearchOptionsState copyWith({
    List<String> query,
    List<String> options,
    SearchByOptionsStatus status,
  }) {
    return SearchOptionsState(
      query: query ?? this.query,
      options: options ?? this.options,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [query, options, status];
}
