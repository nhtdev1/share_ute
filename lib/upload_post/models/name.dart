import 'package:equatable/equatable.dart';

class Name extends Equatable{
  const Name._({this.value = ''});

  final String value;

  const Name.pure() : this._();

  const Name.dirty(String value) : this._(value: value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}
