part of 'tag_bloc.dart';

class TagState extends Equatable {
  const TagState({
    this.status = FormzStatus.pure,
    this.tagName = const TagName.pure(),
  });

  final FormzStatus status;
  final TagName tagName;

  TagState copyWith({
    FormzStatus status,
    TagName tagName,
  }) {
    return TagState(
        status: status ?? this.status, tagName: tagName ?? this.tagName);
  }

  @override
  // TODO: implement props
  List<Object> get props => [status, tagName];
}
