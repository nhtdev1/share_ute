import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_ute/app.dart';
import 'package:share_ute/blocs/intro_bloc.dart';
import 'package:share_ute/views/intro_pages/first_view.dart';
import 'package:share_ute/views/intro_pages/second_view.dart';
import 'package:share_ute/views/intro_pages/third_view.dart';

class MyIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  IntroBloc _bloc = new IntroBloc();
  var _typeTraining = TYPE_TRAINING.NONE;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff2980B9) : Color(0xff6DD5FA),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void setTypeTraining(TYPE_TRAINING type) {
    _typeTraining = type;
    _bloc.loadDataMajor(type);
    _bloc.loadDataSubject(0);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff2980B9),
                Color(0xff6DD5FA),
                Color(0xffFFFFFF),
                Color(0xffFFFFFF),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      _bloc.dispose();
                      _gotoMain();
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.8, //600.0,
                  child: PageView(
                    physics: _typeTraining != null
                        ? ClampingScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      FirstView(
                        onChose: setTypeTraining,
                        curType: _typeTraining,
                      ),
                      SecondView(major: _bloc.getMajor),
                      ThirdView(
                        subject: _bloc.getSubject,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Color(0xff2980B9),
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xff2980B9),
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: size.height * 0.05,
              width: double.infinity,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  _bloc.dispose();
                  _gotoMain();
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      'GET STARTED',
                      style: TextStyle(
                        color: Color(0xff2980B9),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }

  void _gotoMain() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => App()));
  }
}
