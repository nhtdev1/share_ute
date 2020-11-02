part of 'intro_form.dart';

PageViewModel getMajorInfoView({Widget image, PageDecoration pageDecoration}) {
  return PageViewModel(
    title: "Which major are you a student?",
    body: 'Body',
    image: image,
    decoration: pageDecoration,
  );
}
