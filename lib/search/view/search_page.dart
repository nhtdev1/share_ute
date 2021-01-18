import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/main_screen/main_screen.dart';
import 'package:share_ute/search/search.dart';
import 'package:share_ute/search_premium/search_premium.dart';

class SearchPage extends SearchDelegate<String> {
  SearchPage({this.searchCubit});

  final SearchCubit searchCubit;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close_outlined),
        onPressed: () {
          query = '';
          searchCubit.clear();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_outlined),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) return buildSuggestions(context);

    return BlocBuilder<SearchCubit, SearchState>(
      cubit: searchCubit..getResults(query),
      builder: (context, state) {
        if (state.searchProgress == SearchProgress.submissionInProgress) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.searchProgress == SearchProgress.submissionFailure) {
          return Container(
            child: Center(
              child: Text('Đã có lỗi xảy ra'),
            ),
          );
        }

        if (state.results.isEmpty) {
          return ListView(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            children: [
              Row(
                children: [
                  Text(
                    'Nội dung tìm kiếm:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Spacer(),
                  Text(
                    'Kết quả tìm được',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
              _TrackFilterResult(state.trackFilters),
              Divider(),
              Text(
                'Kết hợp các bộ lọc của bạn',
                style: TextStyle(fontSize: 18.0),
              ),
              _TrackFilterDetail(state.trackFilters),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Tổng thời gian: ${Random().nextDouble() * 0.2}s',
                        style: TextStyle(fontSize: 15.5),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Kết quả: không tìm thấy bài viết phù hợp',
                        style: TextStyle(fontSize: 15.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return SearchResultForm(posts: state.results);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final historyQuery = Filter.historyQuery
        .where((element) => element.toLowerCase().contains(query));

    return query.trim().length == 0
        ? NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return SearchPremiumPage();
                    },
                    childCount: 1,
                  ),
                )
              ];
            },
            body: _FilterOptions(),
          )
        : ListView(
            children: historyQuery
                .map<ListTile>(
                  (a) => ListTile(
                    leading: Icon(Icons.history),
                    title: Text(
                      a.toString(),
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onTap: () {
                      query = a;
                    },
                  ),
                )
                .toList(),
          );
  }

  @override
  String get searchFieldLabel => 'Tôi cần tìm...';

  @override
  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      );
}

class _FilterOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return ListView(
          children: Filter.options
              .map<ListTile>(
                (a) => a.option == FilterOptions.unknown
                    ? ListTile(title: Text(a.title))
                    : ListTile(
                        title: Text(a.title),
                        leading: a.icon,
                        trailing: (state.typeOption == a.option) ||
                                (state.dateOption == a.option)
                            ? Icon(
                                Icons.check_box,
                                color: Colors.lightBlueAccent,
                              )
                            : null,
                        onTap: () {
                          context.read<SearchCubit>().changedOptions(a.option);
                        },
                      ),
              )
              .toList(),
        );
      },
    );
  }
}

class _TrackFilterResult extends StatelessWidget {
  _TrackFilterResult(this.list);

  final List<TrackFilter> list;
  @override
  Widget build(BuildContext context) {
    final result = list
        .map(
          (e) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      TrackFilter.getInfoOption(e),
                      style: TextStyle(fontSize: 15.5),
                    ),
                  ),
                  Spacer(),
                  RaisedButton(
                    color: e.result.length > 0 ? Colors.lightBlueAccent : null,
                    child: Text(
                      e.result.length.toString() + ' bài viết',
                      style: TextStyle(
                        fontSize: 15.5,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      return SearchResultForm(posts: e.result);
                    },
                  ),
                  const SizedBox(width: 5),
                ],
              )),
        )
        .toList();
    return Wrap(children: result);
  }
}

class _TrackFilterDetail extends StatelessWidget {
  _TrackFilterDetail(this.list);

  final List<TrackFilter> list;
  @override
  Widget build(BuildContext context) {
    final result = list
        .map((e) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent)),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 5,
                    child: Text(
                      TrackFilter.getInfoOptionValues(e),
                      style: TextStyle(fontSize: 15.5),
                    ),
                  ),
                  Expanded(child: _buildOptionValues(e.optionValues)),
                  const SizedBox(width: 5),
                ],
              ),
            ))
        .toList();
    return Wrap(children: result);
  }

  _buildOptionValues(List<String> options) {
    final result = options
        .map((option) => Container(
              child: Chip(
                backgroundColor: Colors.lightBlueAccent,
                label: Text(
                  option,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ))
        .toList();
    return Wrap(children: result);
  }
}
