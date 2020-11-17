import 'package:equatable/equatable.dart';

class Extension extends Equatable{
  const Extension._({this.value = ''});

  final String value;

  const Extension.pure() : this._();

  const Extension.dirty(String value) : this._(value: value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}
