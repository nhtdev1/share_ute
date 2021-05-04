import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/messenger/messenger.dart';

class AppBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerCubit, MessengerState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  context.read<MessengerCubit>().queryChanged(value);
                },
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'WorkSans',
                ),
                decoration: InputDecoration(
                  hintText: "Tìm kiếm người dùng...",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
