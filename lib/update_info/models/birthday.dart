import 'package:equatable/equatable.dart';

class Birthday extends Equatable {
  const Birthday._({this.value});

  final String value;

  const Birthday.pure([String value = '']) : this._(value: value);

  const Birthday.dirty([String value = '']) : this._(value: value);

  @override
  List<Object> get props => [value];

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;
}
