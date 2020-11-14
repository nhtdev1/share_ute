import 'package:formz/formz.dart';

enum MobileValidationError { invalid }

class Mobile extends FormzInput<String, MobileValidationError> {
  const Mobile.pure([String value = '']) : super.pure(value);

  const Mobile.dirty([String value = '']) : super.dirty(value);

  static final RegExp _phoneRegExp = RegExp(
    r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',
  );

  @override
  MobileValidationError validator(String value) {
    return _phoneRegExp.hasMatch(value)?null:MobileValidationError.invalid;
  }
}