import 'package:flutter/material.dart';
import 'package:share_ute/views/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_ute/widgets/textfield_container.dart';
import 'package:share_ute/utils/responsive.dart';

class MySignUp extends StatelessWidget {
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
              home: LoginPage(),
            );
          },
        );
      },
    );
  }
}

class SignUpPage extends StatefulWidget {
  /// Text field controllers
  final TextEditingController userFieldController;
  final TextEditingController pwdFieldController;

  /// Values changed
  final ValueChanged<String> userFieldChanged;
  final ValueChanged<String> pwdFieldChanged;

  /// Callback functions
  final Function signUpCallback;
  final Function googleSignUpCallback;

  const SignUpPage({
    Key key,
    this.userFieldController,
    this.userFieldChanged,
    this.pwdFieldChanged,
    this.pwdFieldController,
    this.signUpCallback,
    this.googleSignUpCallback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _isShowPassword = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        // Here i can use size.width but use double.infinity because both work as a same
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
                width: 25 * Responsive.imageSizeMultiplier,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/signup_bottom.png",
                width: 25 * Responsive.imageSizeMultiplier,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 3 * Responsive.heightMultiplier,
                  ),
                  Container(
                    height: 35 * Responsive.heightMultiplier,
                    child: Image.asset("assets/images/HCMUTE.png"),
                  ),
                  SizedBox(height: 5 * Responsive.heightMultiplier),

                  /// Text box Email
                  TextFieldContainer(
                    child: TextField(
                      onChanged: widget.userFieldChanged,
                      controller: widget.userFieldController,
                      cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.lightBlue,
                        ),
                        hintText: "Your Email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1 * Responsive.heightMultiplier,
                  ),

                  /// Text box Password
                  TextFieldContainer(
                    child: TextField(
                      obscureText: !_isShowPassword,
                      onChanged: widget.pwdFieldChanged,
                      controller: widget.pwdFieldController,
                      cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: Colors.lightBlue,
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
                            color: Colors.lightBlue,
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3 * Responsive.heightMultiplier,
                  ),

                  /// Button Sign Up
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: Colors.lightBlue,
                        onPressed: () {
                          widget.signUpCallback();
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3 * Responsive.heightMultiplier,
                  ),

                  /// Link redirect Sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an Account ? ",
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),

                  /// Div line
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2 * Responsive.heightMultiplier),
                    width: 90 * Responsive.widthMultiplier,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: Color(0xFFD9D9D9),
                            height: 1.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xFFD9D9D9),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Action with google
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: size.width * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 10),
                              color: Colors.red,
                              onPressed: () {
                                widget.googleSignUpCallback();
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Sign up with",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SvgPicture.asset(
                                    "assets/icons/google.svg",
                                    width: 20,
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
