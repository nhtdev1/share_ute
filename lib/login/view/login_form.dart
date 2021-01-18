import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_ute/login/login.dart';
import 'package:formz/formz.dart';
import 'package:share_ute/sign_up/sign_up.dart';

// The LoginForm is a responsible for rendering the form in response to the
// LoginState and invokes methods LoginCubit in response to user interactions
class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo_utes.png',
                height: MediaQuery.of(context).size.height * 2 / 5,
              ),
              const SizedBox(
                height: 10.0,
              ),
              _EmailInput(),
              const SizedBox(
                height: 8.0,
              ),
              _PasswordInput(),
              const SizedBox(
                height: 8.0,
              ),
              _LoginButton(),
              const SizedBox(
                height: 8.0,
              ),
              _GoogleLoginButton(),
              const SizedBox(
                height: 4.0,
              ),
              _FacebookLoginButton(),
              const SizedBox(
                height: 4.0,
              ),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            style: TextStyle(
              fontSize: 16,
            ),
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                context.watch<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'Tài khoản',
                errorText: state.email.invalid ? 'mail không hợp lệ' : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.8,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.8,
                  ),
                ),
                prefixIcon: Padding(
                  child: IconTheme(
                    data: IconThemeData(color: Theme.of(context).primaryColor),
                    child: Icon(
                      Icons.email,
                      size: 20,
                    ),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                )),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            style: TextStyle(
              fontSize: 16,
            ),
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.watch<LoginCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'Mật khẩu',
                errorText:
                    state.password.invalid ? 'mật khẩu không hợp lệ' : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.8,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 0.8,
                  ),
                ),
                prefixIcon: Padding(
                  child: IconTheme(
                    data: IconThemeData(color: Theme.of(context).primaryColor),
                    child: Icon(
                      Icons.lock,
                      size: 20,
                    ),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                )),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(
                strokeWidth: 2,
              )
            : RaisedButton(
                highlightElevation: 0.0,
                elevation: 0.0,
                color: Colors.blueAccent,
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                onPressed: state.status.isValidated
                    ? () => context.watch<LoginCubit>().logInWithCredentials()
                    : null,
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 3 / 5,
      child: RaisedButton.icon(
        padding: const EdgeInsets.all(8.0),
        color: Colors.blueAccent,
        key: const Key('loginForm_googleLogin_raisedButton'),
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
        icon: const Icon(
          FontAwesomeIcons.googlePlusSquare,
          color: Colors.white,
        ),
        label: const Text(
          '  Đăng nhập với Google  ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}

class _FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 3 / 5,
      child: RaisedButton.icon(
        padding: const EdgeInsets.all(8.0),
        color: Colors.blueAccent,
        key: const Key('loginForm_facebookLogin_raisedButton'),
        onPressed: () => context.read<LoginCubit>().logInWithFacebook(),
        icon: const Icon(
          FontAwesomeIcons.facebookSquare,
          color: Colors.white,
        ),
        label: const Text(
          'Đăng nhập với Facebook',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      key: const Key('loginForm_createAccount_flatButton'),
      child: Text(
        'Tạo tài khoản',
        style: TextStyle(
          color: Colors.greenAccent,
        ),
      ),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
    );
  }
}
