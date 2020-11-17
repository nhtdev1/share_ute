import 'package:equatable/equatable.dart';

class Year extends Equatable{
  const Year._({this.value = ''});

  final String value;

  const Year.pure() : this._();

  const Year.dirty(String value) : this._(value: value);

  @override
  // TODO: implement props
  List<Object> get props => [value];

  bool get isNotEmpty => value.trim() != '';
}
