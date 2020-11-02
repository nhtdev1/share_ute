import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

// The SignUpForm is a responsible for rendering the form in response to the
// SignUpState and invokes methods on the SignUpBit in response to user interactions
class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Container(
        color: Colors.white,
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _EmailInput(),
              const SizedBox(
                height: 8,
              ),
              _PasswordInput(),
              const SizedBox(
                height: 8,
              ),
              _ConfirmPasswordInput(),
              const SizedBox(
                height: 8,
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            style: TextStyle(
              fontSize: 16,
            ),
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (email) =>
                context.bloc<SignUpCubit>().emailChanged(email),
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
                    child: Icon(Icons.email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            style: TextStyle(
              fontSize: 16,
            ),
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) =>
                context.bloc<SignUpCubit>().passwordChange(password),
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
                    child: Icon(Icons.lock),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                )),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            style: TextStyle(
              fontSize: 16,
            ),
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
            onChanged: (confirmedPassword) => context
                .bloc<SignUpCubit>()
                .confirmedPasswordChanged(confirmedPassword),
            obscureText: true,
            decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
                hintText: 'CONFIRM PASSWORD',
                errorText: state.confirmedPassword.invalid
                    ? 'password do not match'
                    : null,
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
                    child: Icon(Icons.lock),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                )),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(
                strokeWidth: 2,
              )
            : RaisedButton(
                key: const Key('signUpForm_continue_raisedButton'),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.orangeAccent,
                onPressed: state.status.isValidated
                    ? () => context.bloc<SignUpCubit>().signUpFormSubmitted()
                    : null,
              );
      },
    );
  }
}
