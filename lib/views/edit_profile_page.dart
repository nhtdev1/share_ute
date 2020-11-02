import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_ute/widgets/textfield_container.dart';
import 'package:share_ute/utils/responsive.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool _isShowPassword = false;
  DateTime dayOfBirth = DateTime.now();
  int genderIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
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
                                    Icons.camera_alt,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onTap: () {},
                                ))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  /// Text box User Name
                  TextFieldContainer(
                    borderRadius: 15.0,
                    backColor: Colors.grey[200],
                    child: TextField(
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
                  const SizedBox(
                    height: 2,
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
                      Spacer(),

                      /// Gender
                      radioCustom(
                          iconSvg: "assets/icons/male.svg",
                          widthIcon: 5,
                          heightIcon: 5,
                          index: 0),
                      const SizedBox(
                        width: 10,
                      ),
                      radioCustom(
                          iconSvg: "assets/icons/female.svg",
                          widthIcon: 5,
                          heightIcon: 5,
                          index: 1),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  /// Text box Password
                  TextFieldContainer(
                    borderRadius: 15.0,
                    backColor: Colors.grey[200],
                    child: TextField(
                      obscureText: !_isShowPassword,
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

                  /// Text box Password
                  TextFieldContainer(
                    borderRadius: 15.0,
                    backColor: Colors.grey[200],
                    child: TextField(
                      obscureText: !_isShowPassword,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: "New Password",
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

                  /// Text box Password
                  TextFieldContainer(
                    borderRadius: 15.0,
                    backColor: Colors.grey[200],
                    child: TextField(
                      obscureText: !_isShowPassword,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
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
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {},
                        child: Text("CANCEL",
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1.5,
                              color: Colors.black,
                            )),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.lightBlue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
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

