import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/introduction_screen/introduction_screen.dart';

part 'year_info_view.dart';

part 'faculty_info_view.dart';

part 'major_info_view.dart';

part 'hobbies_info_view.dart';

class IntroForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ));
    return IntroductionScreen(
      pages: [
        _buildYearPageModel(
          image: _holderImage('assets/images/intro.png'),
          pageDecoration: pageDecoration,
        ),
        _buildFacultyPageModel(
          image: _holderImage('assets/images/intro.png'),
          pageDecoration: pageDecoration,
        ),
        _buildMajorPageModel(
          image: _holderImage('assets/images/intro.png'),
          pageDecoration: pageDecoration,
        ),
        _buildHobbiesPageModel(
          image: _holderImage('assets/images/intro.png'),
          pageDecoration: pageDecoration,
        ),
      ],
      onDone: () {
        context.read<IntroductionCubit>().done();
      },
      onChange: (value) {},
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Bỏ qua'),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        'Xong',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          )),
    );
  }

  Widget _holderImage(String assetPath) {
    return Align(
      child: Image.asset(
        assetPath,
        width: 220,
      ),
      alignment: Alignment.bottomCenter,
    );
  }
}
