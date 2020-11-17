import 'package:equatable/equatable.dart';

class Tags extends Equatable{
  const Tags._({this.value = const []});

  final List<String> value;

  const Tags.pure() : this._();

  const Tags.dirty(List<String> value) : this._(value: value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}
