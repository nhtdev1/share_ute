import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/search_popular_tags/search_popular_tags.dart';

class SearchPopularTagsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _PopularTagsToolbar(),
        _TopTags(),
      ],
    );
  }
}

class _PopularTagsToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPopularTagsCubit, SearchPopularTagsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Text('Tìm theo các từ khóa phổ biến'),
            Switch(
              value: state.status == SearchByPopularTagsStatus.disallowed
                  ? false
                  : true,
              onChanged: (value) {
                context.read<SearchPopularTagsCubit>().switchSearch();
              },
            ),
            Spacer(),
            IconButton(
              icon: state.viewMode == ViewMode.horizontal
                  ? Icon(
                      Icons.view_module,
                      color: Colors.grey,
                    )
                  : Icon(
                      Icons.view_list,
                      color: Colors.grey,
                    ),
              onPressed: () {
                context.read<SearchPopularTagsCubit>().switchViewMode();
              },
            ),
            const SizedBox(width: 5),
          ],
        );
      },
    );
  }
}

class _TopTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPopularTagsCubit, SearchPopularTagsState>(
      builder: (context, state) {
        List<Widget> chips = [];
        state.topTags.forEach((element) {
          chips.add(
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(2.0),
                child: Chip(
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                  backgroundColor: state.query.contains(element)
                      ? Colors.lightBlueAccent.withOpacity(0.8)
                      : Colors.grey.withOpacity(0.5),
                  label: Text(element),
                ),
              ),
              onTap: () {
                context.read<SearchPopularTagsCubit>().changedQuery(element);
              },
            ),
          );
        });
        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          scrollDirection: state.viewMode == ViewMode.vertical
              ? Axis.vertical
              : Axis.horizontal,
          child: Center(
            child: Wrap(
              children: chips,
            ),
          ),
        );
      },
    );
  }
}
