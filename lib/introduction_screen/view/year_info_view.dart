part of 'intro_form.dart';

PageViewModel getYearInfoView({Widget image, PageDecoration pageDecoration}) {
  return PageViewModel(
    title: "What is your admission year?",
    image: image,
    decoration: pageDecoration,
    bodyWidget: BlocBuilder<IntroductionCubit, IntroductionState>(
      buildWhen: (previous, current) =>
          previous.selectedYear.currentSelected !=
          current.selectedYear.currentSelected,
      builder: (context, state) {
        List<Widget> choices = List();
        state.selectedYear.yearList.forEach((element) {
          choices.add(Container(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              label: Text(element),
              selected: state.selectedYear.currentSelected == element,
              onSelected: (selected) {
                context.bloc<IntroductionCubit>().yearChanged(element);
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
