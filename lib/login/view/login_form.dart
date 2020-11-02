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
                context.bloc<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'EMAIL',
                errorText: state.email.invalid ? 'invalid email' : null,
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
                context.bloc<LoginCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'PASSWORD',
                errorText: state.password.invalid ? 'invalid password' : null,
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
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                onPressed: state.status.isValidated
                    ? () => context.bloc<LoginCubit>().logInWithCredentials()
                    : null,
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      padding: const EdgeInsets.all(8.0),
      color: Colors.lightBlueAccent,
      key: const Key('loginForm_googleLogin_raisedButton'),
      onPressed: () => context.bloc<LoginCubit>().logInWithGoogle(),
      icon: const Icon(
        FontAwesomeIcons.google,
        color: Colors.redAccent,
      ),
      label: const Text(
        'Sign in with Google',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
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
        'CREATE ACCOUNT',
        style: TextStyle(
          color: Colors.greenAccent.withOpacity(0.8),
        ),
      ),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
    );
  }
}
