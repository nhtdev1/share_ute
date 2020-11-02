part of 'intro_form.dart';

PageViewModel getFacultyInfoView(
    {Widget image, PageDecoration pageDecoration}) {
  return PageViewModel(
    title: "Which faculty student are you?",
    body: 'Body',
    image: image,
    decoration: pageDecoration,
  );
}
