import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_ute/widgets/textfield_container.dart';
import 'package:share_ute/utils/responsive.dart';

class MyEditProfile extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            Responsive().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'UTEShare',
              home: EditProfilePage(),
            );
          },
        );
      },
    );
  }
}

class EditProfilePage extends StatefulWidget {
  /// Controller
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController addressController;

  /// Sự kiện thay đổi text
  final ValueChanged<String> onFullNameChanged;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onAddressChanged;

  /// Functions callback
  final Function changeCoverCallback;
  final Function cancelCallback;
  final Function saveCallback;

  const EditProfilePage(
      {Key key,
      this.fullNameController,
      this.emailController,
      this.passwordController,
      this.addressController,
      this.onFullNameChanged,
      this.onEmailChanged,
      this.onPasswordChanged,
      this.onAddressChanged,
      this.changeCoverCallback,
      this.cancelCallback,
      this.saveCallback})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _isShowPassword = false;
  DateTime dayOfBirth = DateTime.now();
  int genderIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CupertinoColors.white,
          leading: CupertinoButton(
            child: Icon(
              const IconData(0xf4fd,
                  fontFamily: CupertinoIcons.iconFont,
                  fontPackage: CupertinoIcons.iconFontPackage),
              color: CupertinoColors.systemGrey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return ClipPath(
                  clipper: DrawClip(_controller.value),
                  child: Container(
                    height: 30 * Responsive.heightMultiplier,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xff2980B9), Color(0xff6DD5FA)]),
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10 * Responsive.heightMultiplier,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 35 * Responsive.imageSizeMultiplier,
                            height: 35 * Responsive.imageSizeMultiplier,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "https://i.pinimg.com/originals/bc/27/2f/bc272f93e93f60e25923b342fcf92ba2.jpg",
                                    ))),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.lightBlue,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onTap: () {
                                      widget.changeCoverCallback();
                                    },
                                  ))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5 * Responsive.heightMultiplier,
                    ),

                    /// Text box User Name
                    TextFieldContainer(
                      borderRadius: 15.0,
                      backColor: Colors.grey[200],
                      child: TextField(
                        onChanged: null,
                        controller: null,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          hintText: "Your Name",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2 * Responsive.heightMultiplier,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// Box Day Of Birth
                        TextFieldContainer(
                          width: size.width / 2,
                          borderRadius: 15.0,
                          backColor: Colors.grey[200],
                          child: TextField(
                            onChanged: null,
                            controller: null,
                            readOnly: true,
                            cursorColor: Colors.grey,
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime(1900, 1, 1),
                                maxTime: DateTime.now(),
                                currentTime: dayOfBirth,
                                locale: LocaleType.en,
                                //Vi là Việt Nam format
                                onChanged: (date) {},
                                onConfirm: (date) {
                                  dayOfBirth = date;
                                },
                              );
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                              ),
                              hintText: formatDate(dayOfBirth),
                              hintStyle: TextStyle(color: Colors.black),
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 30,
                        ),

                        /// Gender
                        radioCustom(
                            iconSvg: "assets/icons/male.svg",
                            widthIcon: 5,
                            heightIcon: 5,
                            index: 0),
                        SizedBox(
                          width: 15,
                        ),
                        radioCustom(
                            iconSvg: "assets/icons/female.svg",
                            widthIcon: 5,
                            heightIcon: 5,
                            index: 1),
                      ],
                    ),
                    SizedBox(height: 2 * Responsive.heightMultiplier),

                    /// Text box Password
                    TextFieldContainer(
                      borderRadius: 15.0,
                      backColor: Colors.grey[200],
                      child: TextField(
                        obscureText: !_isShowPassword,
                        onChanged: null,
                        controller: null,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isShowPassword = !_isShowPassword;
                              });
                            },
                            child: Icon(
                              _isShowPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _isShowPassword
                                  ? Colors.lightBlue
                                  : Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 2 * Responsive.heightMultiplier),

                    /// Text box Address
                    TextFieldContainer(
                      borderRadius: 15.0,
                      backColor: Colors.grey[200],
                      child: TextField(
                        onChanged: null,
                        controller: null,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.home,
                            color: Colors.grey,
                          ),
                          hintText: "Address",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5 * Responsive.heightMultiplier,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlineButton(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            widget.cancelCallback();
                          },
                          child: Text("CANCEL",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black)),
                        ),
                        RaisedButton(
                          onPressed: () {
                            widget.saveCallback();
                          },
                          color: Colors.lightBlue,
                          //Color.fromRGBO(49, 39, 79, 1),
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget radioCustom(
      {String iconSvg, double widthIcon, double heightIcon, int index}) {
    return GestureDetector(
        onTap: () {
          setState(() {
            genderIndex = index;
          });
        },
        child: Container(
            padding: EdgeInsets.all(10),
            height: widthIcon + 40,
            width: heightIcon + 40,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: genderIndex == index
                      ? Colors.lightBlue[700]
                      : Colors.grey[300],
                )),
            child: GestureDetector(
              child: SvgPicture.asset(
                iconSvg,
                width: widthIcon != null ? widthIcon : 10.0,
                height: heightIcon != null ? heightIcon : 10.0,
                color: genderIndex == index
                    ? Colors.lightBlue[700]
                    : Colors.grey[300],
              ),
              onTap: () {
                setState(() {
                  genderIndex = index;
                });
              },
            )));
  }

  String formatDate(DateTime dateTime) {
    var date = dateTime.toString();
    var dateParse = DateTime.parse(date);
    var formattedDate =
        "${dateParse.day} - ${dateParse.month} - ${dateParse.year}";
    return formattedDate.toString();
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;

  DrawClip(this.move);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
