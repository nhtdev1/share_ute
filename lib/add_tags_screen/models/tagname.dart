import 'package:formz/formz.dart';

enum TagNameValidationError { empty }

class TagName extends FormzInput<String, TagNameValidationError> {
  const TagName.pure() : super.pure('');

  const TagName.dirty([String value = '']) : super.dirty(value);

  @override
  TagNameValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : TagNameValidationError.empty;
  }
}
