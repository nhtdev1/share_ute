import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordValidationError { invalid }

// Extend FormzInput and provide the input type and error type.
class Password extends FormzInput<String, PasswordValidationError> {
  // Call super.pure to represent an unmodified form input.
  const Password.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  // Override validator to handle validating a given input value.
  @override
  PasswordValidationError validator(String value) {
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
