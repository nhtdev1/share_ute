import 'package:equatable/equatable.dart';

class Size extends Equatable{
  const Size._({this.value = ''});

  final String value;

  const Size.pure() : this._();

  const Size.dirty(String value) : this._(value: value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}
