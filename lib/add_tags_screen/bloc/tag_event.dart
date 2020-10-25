part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TagNameChanged extends TagEvent {
  const TagNameChanged(this.tagName);

  final String tagName;

  @override
  // TODO: implement props
  List<Object> get props => [tagName];
}
