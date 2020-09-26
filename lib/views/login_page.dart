///
/// Trang được gọi khi bắt đầu ứng dụng (nếu chưa có sự đăng nhập trước đó)
/// Hoặc khi người dùng đăng xuất khỏi ứng dụng
///

import 'package:flutter/material.dart';
import 'package:share_ute/animations/fade_animation.dart';

class LoginPage extends StatefulWidget {
  /// Sự kiện khi có sự thay đổi nội dung username và password
  final ValueChanged<String> onUserNameChanged;
  final ValueChanged<String> onPasswordChanged;

  /// Sử dụng lấy nội dung username và password khi cần
  final TextEditingController userNameController;
  final TextEditingController passwordController;

  /// Hàm callback khi ấn nút đăng nhập
  final Function signInCallback;

  /// Hàm callback khi ấn nút quên mật khẩu
  final Function forgotPwdCallback;

  /// Hàm callback khi ấn nút đăng nhập qua Google
  final Function signInGoogleCallback;

  const LoginPage(
      {Key key,
      this.onUserNameChanged,
      this.onPasswordChanged,
      this.userNameController,
      this.passwordController,
      this.signInCallback,
      this.forgotPwdCallback,
      this.signInGoogleCallback})
      : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Biến sử dụng hiển thị hoặc ẩn mật khẩu
  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: height / 2,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: height / 2,
                    width: width,
                    child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/login_background.png'),
                                  fit: BoxFit.fill)),
                        )),
                  ),
                  Positioned(
                    height: height / 2,
                    width: width + 20,
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/login_foreground.png'),
                                  fit: BoxFit.fill)),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      Text(
                        "Sign in",
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.7,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[200]))),
                              child: TextField(
                                controller: widget.userNameController,
                                onChanged: widget.onUserNameChanged,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: widget.passwordController,
                                onChanged: widget.onPasswordChanged,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey),
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
                                    ),
                                  ),
                                ),
                                obscureText: !_isShowPassword,
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.7,
                      Center(
                          child: GestureDetector(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Color.fromRGBO(196, 135, 198, 1)),
                            ),
                            onTap: () {
                              widget.forgotPwdCallback();
                            },
                      ))),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.9,
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromRGBO(49, 39, 79, 1),
                        ),
                        child: Center(
                            child: GestureDetector(
                              child: Text(
                                "Sign in",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                widget.signInCallback();
                              },
                        )),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      2,
                      Center(
                          child: GestureDetector(
                            child: Text(
                              "Sign in with Google?",
                              style:
                                  TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
                            ),
                            onTap: () {
                              widget.signInGoogleCallback();
                            },
                      ))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
