import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/search_owner_tags/search_owner_tags.dart';

class SearchOwnerTagsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _OwnTagsToolbar(),
        _OwnTags(),
        _TextFieldTags(),
      ],
    );
  }
}

class _OwnTagsToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchOwnerTagsCubit, SearchOwnerTagsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Text('Tìm theo các tag của riêng bạn'),
            Switch(
              value: state.status == SearchByOwnerTagsStatus.disallowed
                  ? false
                  : true,
              onChanged: (value) {
                context.read<SearchOwnerTagsCubit>().switchSearch();
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
                context.read<SearchOwnerTagsCubit>().switchViewMode();
              },
            ),
            const SizedBox(width: 5),
          ],
        );
      },
    );
  }
}

class _OwnTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchOwnerTagsCubit, SearchOwnerTagsState>(
      builder: (context, state) {
        List<Widget> chips = [];
        state.query.forEach((element) {
          chips.add(
            Container(
              padding: const EdgeInsets.all(2.0),
              child: Chip(
                deleteIconColor: Colors.white,
                onDeleted: () {
                  context.read<SearchOwnerTagsCubit>().removeTag(element);
                },
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
                backgroundColor: Colors.lightBlueAccent.withOpacity(0.8),
                label: Text(
                  element,
                ),
              ),
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

class _TextFieldTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final margin = MediaQuery.of(context).size.width / 4;
    return BlocBuilder<SearchOwnerTagsCubit, SearchOwnerTagsState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(left: margin, right: margin),
          child: TextField(
            controller: TextEditingController()..text = '',
            onSubmitted: (value) {
              context.read<SearchOwnerTagsCubit>().changedTags(value);
            },
            maxLength: 20,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
            ),
          ),
        );
      },
    );
  }
}
