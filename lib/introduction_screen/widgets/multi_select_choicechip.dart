import 'package:flutter/material.dart';
import 'package:share_ute/introduction_screen/cubit/introduction_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiSelectChoiceChip extends StatefulWidget {
  final List<String> choiceList;

  MultiSelectChoiceChip({this.choiceList});

  @override
  _MultiSelectChoiceChipState createState() => _MultiSelectChoiceChipState();
}

class _MultiSelectChoiceChipState extends State<MultiSelectChoiceChip> {
  bool isSelected = false;
  List<String> selectedChoices = List();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.choiceList.forEach((element) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          avatar: selectedChoices.contains(element)
              ? Icon(
                  Icons.check,
                  color: Colors.lightBlueAccent,
                )
              : null,
          label: Text(element),
          selected: selectedChoices.contains(element),
          onSelected: (selected) {
            selectedChoices.contains(element)
                ? selectedChoices.remove(element)
                : selectedChoices.add(element);
            context.bloc<IntroductionCubit>().hobbiesChanged(selectedChoices);
          },
        ),
      ));
    });
    return choices;
  }
}
