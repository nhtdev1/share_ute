import 'package:equatable/equatable.dart';

class AccessModifiers extends Equatable{
  const AccessModifiers._({this.public = true});

  final bool public;

  const AccessModifiers.public() : this._();

  const AccessModifiers.private() : this._(public: false);

  @override
  // TODO: implement props
  List<Object> get props => [public];
}
