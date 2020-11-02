part of 'intro_form.dart';

PageViewModel getHobbiesInfoView(
    {Widget image, PageDecoration pageDecoration}) {
  return PageViewModel(
    title: "Your following feed?",
    bodyWidget: BlocBuilder<IntroductionCubit, IntroductionState>(
      buildWhen: (previous, current) =>
          previous.selectedHobbies.currentSelected !=
          current.selectedHobbies.currentSelected,
      builder: (context, state) {
        List<Widget> choices = List();
        state.selectedHobbies.hobbiesList.forEach((element) {
          choices.add(Container(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              avatar: state.selectedHobbies.currentSelected.contains(element)
                  ? Icon(
                      Icons.check,
                      color: Colors.lightBlueAccent,
                    )
                  : null,
              label: Text(element),
              selected: state.selectedHobbies.currentSelected.contains(element),
              onSelected: (selected) {
                List<String> currentSelectedList = [];
                state.selectedHobbies.currentSelected.forEach((element) {
                  currentSelectedList.add(element);
                });
                currentSelectedList.contains(element)
                    ? currentSelectedList.remove(element)
                    : currentSelectedList.add(element);
                context
                    .bloc<IntroductionCubit>()
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
