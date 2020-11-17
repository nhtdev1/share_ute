import 'package:equatable/equatable.dart';

class Credits extends Equatable{
  const Credits._({this.value = ''});

  final String value;

  const Credits.pure() : this._();

  const Credits.dirty(String value) : this._(value: value);

  @override
  // TODO: implement props
  List<Object> get props => [value];

  bool get isNotEmpty => value.trim() != '';
}
