import 'package:equatable/equatable.dart';

class Major extends Equatable{
  const Major._({this.value = ''});

  final String value;

  const Major.pure() : this._();

  const Major.dirty(String value) : this._(value: value);

  @override
  // TODO: implement props
  List<Object> get props => [value];

  bool get isNotEmpty => value.trim() != '';
}
