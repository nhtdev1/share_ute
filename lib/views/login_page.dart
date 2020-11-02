///
/// Trang được gọi khi bắt đầu ứng dụng (nếu chưa có sự đăng nhập trước đó)
/// Hoặc khi người dùng đăng xuất khỏi ứng dụng
///

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_ute/app.dart';
import 'package:share_ute/views/signup_page.dart';
import 'package:share_ute/widgets/textfield_container.dart';
import 'package:share_ute/utils/responsive.dart';

///
/// Sử dụng tạm lớp này để gọi trang đăng nhập
/// Sau khi đồng bộ code với trang chủ thì hàm này sẽ được đưa ra dùng chung
/// (Tương tự cho các page khác: profile, edit_profile, storage, sign up)
///
class MyLogin extends StatelessWidget {
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


class LoginPage extends StatefulWidget {
  /// Text field controllers
  final TextEditingController userFieldController;
  final TextEditingController pwdFieldController;

  /// Values changed
  final ValueChanged<String> userFieldChanged;
  final ValueChanged<String> pwdFieldChanged;

  /// Callback functions
  final Function signInCallback;
  final Function googleSignUpCallback;

  const LoginPage({
    Key key,
    this.userFieldController,
    this.userFieldChanged,
    this.pwdFieldChanged,
    this.pwdFieldController,
    this.signInCallback,
    this.googleSignUpCallback,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Biến sử dụng hiển thị hoặc ẩn mật khẩu
  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
                width: size.width * 0.35,
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
                    height: 35  * Responsive.heightMultiplier,
                    child: Image.asset("assets/images/HCMUTE.png"),
                  ),
                  SizedBox(height: 5 * Responsive.heightMultiplier,),

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
                  SizedBox(height: 1 * Responsive.heightMultiplier,),

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
                  SizedBox(height: 3 * Responsive.heightMultiplier,),

                  /// Button Sign In
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => App()),
                          // );
                          //widget.signInCallback();
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3 * Responsive.heightMultiplier),

                  /// Link redirect Sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Create new Account ? ",
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return SignUpPage();
                              }));
                        },
                        child: Text(
                          "Sign Up",
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
                                    "Sign in with",
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
