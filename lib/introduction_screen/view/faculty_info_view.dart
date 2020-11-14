part of 'intro_form.dart';

final List<String> facultyList = const [
  'Hệ chất lượng cao',
  'Hệ đại trà',
];

PageViewModel _buildFacultyPageModel(
    {Widget image, PageDecoration pageDecoration}) {
  return PageViewModel(
    title: "Khoa của bạn là?",
    bodyWidget: BlocBuilder<IntroductionCubit, IntroductionState>(
      buildWhen: (previous, current) =>
          previous.faculty.value != current.faculty.value,
      builder: (context, state) {
        List<Widget> faculties = List();
        facultyList.forEach((element) {
          faculties.add(Card(
            child: Center(
              child: ListTile(
                trailing: state.faculty.value == element
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: Colors.lightGreenAccent,
                      )
                    : null,
                title: Text(
                  element,
                  style: TextStyle(
                    fontWeight: state.faculty.value == element
                        ? FontWeight.bold
                        : null,
                  ),
                ),
                onTap: () {
                  context.read<IntroductionCubit>().facultyChanged(element);
                },
              ),
            ),
          ));
        });
        return ListView(
          shrinkWrap: true,
          children: faculties,
        );
      },
    ),
    image: image,
    decoration: pageDecoration,
  );
}
