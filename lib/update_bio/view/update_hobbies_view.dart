import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/update_bio/update_bio.dart';

class UpdateHobbiesView extends StatelessWidget {
  const UpdateHobbiesView({Key key}) : super(key: key);

  final List<String> data = const [
    "Công nghệ thông tin",
    "Kinh tế",
    "Ngôn ngữ Anh",
    "Điện tử",
    "Khoa học tự nhiên",
    "Cơ khí",
    "Lý luận chính trị",
    "Kiến trúc",
    "Biểu mẫu luận văn",
    "Đề tài tốt nghiệp",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBioCubit, UpdateBioState>(
      buildWhen: (previous, current) =>
          previous.user.hobbies != current.user.hobbies,
      builder: (context, state) {
        List<Widget> tiles = List();
        data.forEach((element) {
          tiles.add(Container(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              avatar: state.user.hobbies.contains(element)
                  ? Icon(
                      Icons.check_circle_outline,
                      color: Colors.lightBlueAccent,
                    )
                  : null,
              label: Text(element),
              selected: state.user.hobbies.contains(element),
              onSelected: (selected) {
                List<String> temp = [];
                state.user.hobbies.forEach((element) {
                  temp.add(element);
                });
                temp.contains(element)
                    ? temp.remove(element)
                    : temp.add(element);
                context.read<UpdateBioCubit>().hobbiesChanged(temp);
              },
            ),
          ));
        });

        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.grey,
            ),
            backgroundColor: Colors.transparent,
            shadowColor: Color(0x802196F3),
            elevation: 0.0,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Wrap(
                  children: tiles,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
