import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/select_emoij_type/select_emoij_type.dart';
import 'package:share_ute/upload_comment/upload_comment.dart';

class EmoijListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectEmoijTypeCubit, SelectEmoijTypeState>(
      builder: (context, state) {
        return Flexible(
          child: SingleChildScrollView(
            child: _buidEmoji(state.currentType),
          ),
        );
      },
    );
  }

  Widget _buidEmoji(EmoijType emoijType) {
    final List<Container> smileysAndPeople = _getEmoijListByType(emoijType)
        .map((e) => Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(e, style: TextStyle(fontSize: 25)),
            ))
        .toList();
    return Wrap(
      children: smileysAndPeople,
    );
  }

  List<String> _getEmoijListByType(EmoijType emoijType) {
    switch (emoijType) {
      case EmoijType.smileysAndPeople:
        return Emoji.smileysAndPeople.split(" ");
      case EmoijType.animalsAndNature:
        return Emoji.animalsAndNature.split(" ");
      case EmoijType.foodAndDrink:
        return Emoji.foodAndDrink.split(" ");
      case EmoijType.activities:
        return Emoji.activities.split(" ");
      case EmoijType.travelAndPlaces:
        return Emoji.travelAndPlaces.split(" ");
      case EmoijType.objects:
        return Emoji.objects.split(" ");
      case EmoijType.symbols:
        return Emoji.symbols.split(" ");
      case EmoijType.flags:
        return Emoji.flags.split(" ");
      default:
        return [];
    }
  }
}
