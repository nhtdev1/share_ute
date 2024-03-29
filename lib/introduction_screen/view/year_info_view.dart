part of 'intro_form.dart';

final List<String> yearList = const [
  '2020',
  '2019',
  '2018',
  '2017',
  '2016',
  '2015',
  '2014',
  '2013',
];

PageViewModel _buildYearPageModel(
    {Widget image, PageDecoration pageDecoration}) {
  return PageViewModel(
    title: "Bạn là sinh viên khóa?",
    image: image,
    decoration: pageDecoration,
    bodyWidget: BlocBuilder<IntroductionCubit, IntroductionState>(
      buildWhen: (previous, current) => previous.user.year != current.user.year,
      builder: (context, state) {
        List<Widget> choices = [];
        yearList.forEach((element) {
          choices.add(Container(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              label: Text(element),
              selected: state.user.year == element,
              onSelected: (selected) {
                context.read<IntroductionCubit>().yearChanged(element);
              },
            ),
          ));
        });
        return Wrap(
          children: choices,
        );
      },
    ),
  );
}
