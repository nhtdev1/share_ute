import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upload_post/upload_post.dart';

class UploadMajorView extends StatelessWidget {
  const UploadMajorView({Key key}) : super(key: key);

  final List<String> data = const [
    "CNKT điện, điện tử",
    "CNKT điện tử - viễn thông",
    "CNKT máy tính",
    "CNKT điều khiển và tự động hóa",
    "Kỹ thuật y sinh",
    "Hệ thống nhúng và IoT",
    "Robot và trí tuệ nhân tạo",
    "CN chế tạo máy",
    "CNKT cơ điện tử",
    "CNKT cơ khí",
    "Kỹ thuật công nghiệp",
    "Kỹ nghệ gỗ và nội thất",
    "CNKT công trình xây dựng",
    "Kỹ thuật xây dựng công trình giao thông",
    "Quản lý xây dựng",
    "Hệ thống kỹ thuật công trình xây dựng",
    "CNKT ô tô",
    "CNKT nhiệt",
    "Năng lượng tái tạo",
    "CN thông tin",
    "Kỹ thuật dữ liệu",
    "Quản lý công nghiệp",
    "Kế toán",
    "Thương mại điện tử",
    "Logistics và quản lý chuỗi cung ứng",
    "Kinh doanh Quốc tế",
    "Công nghệ may",
    "CN Kỹ thuật in",
    "Thiết kế đồ họa",
    "Kiến trúc",
    "Kiến trúc nội thất",
    "CNKT môi trường",
    "CN thực phẩm",
    "CNKT hóa học",
    "Quản trị NH và DV ăn uống",
    "Thiết kế thời trang",
    "Sư phạm tiếng Anh",
    "Ngôn ngữ Anh",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
      buildWhen: (previous, current) =>
          previous.post.major != current.post.major,
      builder: (context, state) {
        List<Widget> tiles = List();
        data.forEach((element) {
          tiles.add(
            Material(
              color: Colors.white,
              elevation: 14.0,
              shadowColor: Color(0x802196F3),
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    border: state.post.major == element
                        ? Border.all(
                            color: Colors.lightBlue,
                            width: 1.5,
                          )
                        : null,
                  ),
                  child: ListTile(
                    title: Text(
                      element,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        letterSpacing: 1.0,
                        height: 1.5,
                        fontWeight: state.post.major == element
                            ? FontWeight.bold
                            : null,
                      ),
                    ),
                    trailing: state.post.major == element
                        ? IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.lightBlue,
                            ),
                          )
                        : null,
                  ),
                ),
                onTap: () {
                  if (state.post.major != element) {
                    context.read<UploadPostCubit>().majorChanged(element);
                  } else {
                    context.read<UploadPostCubit>().majorChanged('');
                  }
                },
              ),
            ),
          );
        });

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.grey,
              ),
              backgroundColor: Colors.white,
              elevation: 0.5,
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 2.0,
              ),
              children: tiles,
            ),
          ),
        );
      },
    );
  }
}
