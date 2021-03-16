import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upload_post/upload_post.dart';

class UploadTagsView extends StatelessWidget {
  const UploadTagsView({Key key}) : super(key: key);

  final List<String> data = const [
    "Công nghệ thông tin",
    "Kinh tế - Quản lý",
    "Kinh doanh - Tiếp thị",
    "Ngoại ngữ",
    "Điện tử",
    "Khoa học tự nhiên",
    "Khoa học xã hội",
    "Cơ khí",
    "Kỹ thuật - Công nghệ",
    "Robot - AI",
    "Xây dựng - Kiến trúc",
    "Các môn đại cương",
    "Ô tô",
    "Biểu mẫu - Văn bản",
    "Đồ án - Luận văn"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
      buildWhen: (previous, current) =>
          previous.post.postTags != current.post.postTags,
      builder: (context, state) {
        List<Widget> tiles = [];
        data.forEach((element) {
          tiles.add(Container(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              avatar: state.post.postTags.contains(element)
                  ? Icon(
                      Icons.check_circle_outline,
                      color: Colors.lightBlueAccent,
                    )
                  : null,
              label: Text(element),
              selected: state.post.postTags.contains(element),
              onSelected: (selected) {
                List<String> temp = [];
                state.post.postTags.forEach((element) {
                  temp.add(element);
                });
                temp.contains(element)
                    ? temp.remove(element)
                    : temp.add(element);
                context.read<UploadPostCubit>().postTagsChanged(temp);
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
