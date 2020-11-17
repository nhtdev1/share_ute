import 'package:equatable/equatable.dart';

class Lecturers extends Equatable{
  const Lecturers._({this.value = ''});

  final String value;

  const Lecturers.pure() : this._();

  const Lecturers.dirty(String value) : this._(value: value);

  @override
  // TODO: implement props
  List<Object> get props => [value];

  bool get isNotEmpty => value.trim() != '';
}
