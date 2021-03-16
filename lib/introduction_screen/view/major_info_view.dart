part of 'intro_form.dart';

final List<String> majorList = const [
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

PageViewModel _buildMajorPageModel(
    {Widget image, PageDecoration pageDecoration}) {
  return PageViewModel(
    title: "Bạn học ngành?",
    bodyWidget: BlocBuilder<IntroductionCubit, IntroductionState>(
      builder: (context, state) {
        List<Widget> majors = [];
        majorList.forEach((element) {
          majors.add(Card(
            child: Center(
              child: ListTile(
                trailing: state.user.major == element
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: Colors.lightBlue,
                      )
                    : null,
                title: Text(
                  element,
                  style: TextStyle(
                    color:
                        state.user.major == element ? Colors.lightBlue : null,
                    fontWeight:
                        state.user.major == element ? FontWeight.bold : null,
                  ),
                ),
                onTap: () {
                  context.read<IntroductionCubit>().majorChanged(element);
                },
              ),
            ),
          ));
        });
        return ListView(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          children: majors,
        );
      },
    ),
    image: image,
    decoration: pageDecoration,
  );
}
