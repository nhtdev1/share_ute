import 'package:equatable/equatable.dart';

class Semester extends Equatable{
  const Semester._({this.value = ''});

  final String value;

  const Semester.pure() : this._();

  const Semester.dirty(String value) : this._(value: value);

  @override
  // TODO: implement props
  List<Object> get props => [value];

  bool get isNotEmpty => value.trim() != '';
}
