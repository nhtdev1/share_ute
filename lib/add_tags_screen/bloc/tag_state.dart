part of 'tag_bloc.dart';

class TagState {
  TagState({this.status, this.tagName, this.tagSuggestion});

  FormzStatus status = FormzStatus.pure;
  TagName tagName = TagName.pure();
  TagSuggestion tagSuggestion = TagSuggestion();

  TagState copyWith({
    FormzStatus status,
    TagName tagName,
    TagSuggestion tagSuggestion,
  }) {
    return TagState(
        status: status ?? this.status,
        tagName: tagName ?? this.tagName,
        tagSuggestion: tagSuggestion ?? this.tagSuggestion);
  }
}
