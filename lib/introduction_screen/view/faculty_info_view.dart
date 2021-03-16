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
          previous.user.faculty != current.user.faculty,
      builder: (context, state) {
        List<Widget> faculties = [];
        facultyList.forEach((element) {
          faculties.add(Card(
            child: Center(
              child: ListTile(
                trailing: state.user.faculty == element
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: Colors.lightBlue,
                      )
                    : null,
                title: Text(
                  element,
                  style: TextStyle(
                    color:
                        state.user.faculty == element ? Colors.lightBlue : null,
                    fontWeight:
                        state.user.faculty == element ? FontWeight.bold : null,
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
