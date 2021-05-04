import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/select_emoij_type/select_emoij_type.dart';

class SelectEmoijTypeForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectEmoijTypeCubit, SelectEmoijTypeState>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
            border: Border(
                top:
                    BorderSide(color: Colors.grey.withOpacity(0.2), width: 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildItem(context, state),
        ),
      );
    });
  }

  List<Expanded> _buildItem(BuildContext context, SelectEmoijTypeState state) {
    return SelectEmoijTypeState.options.keys
        .map(
          (key) => Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: state.currentType == key
                      ? Border(top: BorderSide(width: 2.5, color: Colors.blue))
                      : null),
              child: TextButton(
                child: Text(SelectEmoijTypeState.options[key]),
                onPressed: () {
                  context.read<SelectEmoijTypeCubit>().emoijTypeChanged(key);
                },
              ),
            ),
          ),
        )
        .toList();
  }
}
