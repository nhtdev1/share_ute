import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:share_ute/home/home.dart';
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
    return Container(
      child: IntroductionScreen(
        pages: [
          getYearInfoView(
            image: _holderImage('assets/images/intro.png'),
            pageDecoration: pageDecoration,
          ),
          getFacultyInfoView(
            image: _holderImage('assets/images/intro.png'),
            pageDecoration: pageDecoration,
          ),
          getMajorInfoView(
            image: _holderImage('assets/images/intro.png'),
            pageDecoration: pageDecoration,
          ),
          getHobbiesInfoView(
            image: _holderImage('assets/images/intro.png'),
            pageDecoration: pageDecoration,
          ),
        ],
        onDone: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => HomePage(),
            ),
            (route) => false),
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text(
          'Done',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            )),
      ),
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
