import 'package:formz/formz.dart';

enum TitleValidationError { invalid }

class Title extends FormzInput<String, TitleValidationError> {
  const Title.pure([String value = '']) : super.pure(value);

  const Title.dirty([String value = '']) : super.dirty(value);

  static final RegExp _titleRegExp = RegExp(
    r'^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s\W|_]',
  );

  @override
  TitleValidationError validator(String value) {
    return _titleRegExp.hasMatch(value) == true
        ? null
        : TitleValidationError.invalid;
  }

  bool get isNotEmpty => value.trim() != '';
}
