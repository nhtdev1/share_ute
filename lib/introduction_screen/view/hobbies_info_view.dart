part of 'intro_form.dart';

final List<String> hobbyList = const [
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

PageViewModel _buildHobbiesPageModel(
    {Widget image, PageDecoration pageDecoration}) {
  return PageViewModel(
    title: "Chủ đề bạn quan tâm là?",
    bodyWidget: BlocBuilder<IntroductionCubit, IntroductionState>(
      buildWhen: (previous, current) =>
          previous.hobbies.value != current.hobbies.value,
      builder: (context, state) {
        List<Widget> choices = List();
        hobbyList.forEach((element) {
          choices.add(Container(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              avatar: state.hobbies.value.contains(element)
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.lightBlueAccent,
                    )
                  : null,
              label: Text(element),
              selected: state.hobbies.value.contains(element),
              onSelected: (selected) {
                List<String> currentSelectedList = [];
                state.hobbies.value.forEach((element) {
                  currentSelectedList.add(element);
                });
                currentSelectedList.contains(element)
                    ? currentSelectedList.remove(element)
                    : currentSelectedList.add(element);
                context
                    .read<IntroductionCubit>()
                    .hobbiesChanged(currentSelectedList);
              },
            ),
          ));
        });

        return Wrap(
          children: choices,
        );
      },
    ),
    image: image,
    decoration: pageDecoration,
  );
}
