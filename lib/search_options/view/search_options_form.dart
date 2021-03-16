import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/search_options/search_options.dart';

class SearchOptionsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _OptinalTagsToolbar(),
        _OptinalTags(),
      ],
    );
  }
}

class _OptinalTagsToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchOptionsCubit, SearchOptionsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Text('Tìm theo tính năng của tài liệu'),
            Switch(
              value: state.status == SearchByOptionsStatus.disallowed
                  ? false
                  : true,
              onChanged: (value) {
                context.read<SearchOptionsCubit>().switchSearch();
              },
            ),
            const SizedBox(width: 5),
          ],
        );
      },
    );
  }
}

class _OptinalTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchOptionsCubit, SearchOptionsState>(
      builder: (context, state) {
        List<Widget> chips = [];
        state.options.forEach((element) {
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
                context.read<SearchOptionsCubit>().changedQuery(element);
              },
            ),
          );
        });
        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          scrollDirection: Axis.horizontal,
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
