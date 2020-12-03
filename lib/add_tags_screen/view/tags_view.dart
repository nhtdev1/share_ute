import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:share_ute/add_tags_screen/add_tags_screen.dart';
import 'package:share_ute/add_tags_screen/bloc/tag_bloc.dart';

class TagsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TagBloc, TagState>(
      listener: (context, state) {},
      child: Align(
        child: Column(
          children: [
            _TagNameInput(),
            Expanded(
              child: _ListSuggestions(),
            )
          ],
        ),
      ),
    );
  }
}

class _TagNameInput extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      builder: (context, state) {
        _controller.text = _controller.text + " " + state.tagSuggestion.title;
        return TextFormField(
          controller: _controller,
          key: const Key('_tagNameInput_textField'),
          onChanged: (tagName) {
            context.watch<TagBloc>().add(TagInputChanged(tagName));
          },
          maxLines: 8,
          minLines: 1,
          decoration: InputDecoration(
            hintText: 'tag name',
          ),
        );
      },
    );
  }
}

class _ListSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      buildWhen: (previous, current) => previous.tagName != current.tagName,
      builder: (context, state) {
        return ListView(
          children: TagSuggestion.suggestions
              .map<Container>((a) => a.type == TagSuggestionType.DIVIDER
                  ? Container(
                      child: ListTile(
                        title: Text(
                          a.title,
                        ),
                      ),
                    )
                  : a.type == TagSuggestionType.YEAR
                      ? Container(
                          child: ListTile(
                            leading: GestureDetector(
                              child: a.icon,
                              onTap: () {
                                showYearsPicker(context, a);
                              },
                            ),
                            title: GestureDetector(
                              child: Text(
                                a.title,
                              ),
                              onTap: () {
                                a.isSelected = !a.isSelected;
                                context
                                    .watch<TagBloc>()
                                    .add(TagSuggestionSelected(a));
                              },
                            ),
                          ),
                        )
                      : Container(
                          child: ListTile(
                            leading: a.icon,
                            title: Text(
                              a.title,
                            ),
                            onTap: () {
                              a.isSelected = !a.isSelected;
                              context
                                  .watch<TagBloc>()
                                  .add(TagSuggestionSelected(a));
                            },
                          ),
                        ))
              .toList(),
        );
      },
    );
  }

  showYearsPicker(BuildContext context, TagSuggestion tagSuggestion) {
    Picker(
            adapter: PickerDataAdapter<String>(pickerdata: years),
            hideHeader: true,
            title: Text('Year of document'),
            onConfirm: (picker, value) {})
        .showDialog(context);
  }

  final List<String> years = [
    "Năm 2013 - 2014",
    "Năm 2014 - 2015",
    "Năm 2015 - 2016",
    "Năm 2016 - 2017",
    "Năm 2017 - 2018",
    "Năm 2018 - 2019",
    "Năm 2019 - 2020",
    "Năm 2020 - 2021"
  ];
}

// ? TagSuggestion.suggestions
//     .where((element) =>
// element.title
//     .contains(state.tagName.value.toLowerCase()) ||
// element.title.contains(state.tagName.value.toUpperCase()))
// .map<ListTile>((a) => a.type == TagSuggestionType.DIVIDER
