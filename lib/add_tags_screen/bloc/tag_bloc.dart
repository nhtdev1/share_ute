import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:share_ute/add_tags_screen/add_tags_screen.dart';

part 'tag_event.dart';

part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc() : super(TagState());

  @override
  Stream<TagState> mapEventToState(TagEvent event) async* {
    if (event is TagInputChanged) {
      yield _mapTagNameChangedToState(event, state);
    } else if (event is TagSuggestionSelected) {
      yield _mapTagSuggestionSelectedToState(event, state);
    }
  }

  TagState _mapTagNameChangedToState(
    TagInputChanged event,
    TagState state,
  ) {
    final tagName = TagName.dirty(event.tagInputData);
    return state.copyWith(
        tagName: tagName, status: Formz.validate([state.tagName]));
  }

  TagState _mapTagSuggestionSelectedToState(
    TagSuggestionSelected event,
    TagState state,
  ) {
    return state.copyWith(tagSuggestion: event.tagSuggestion);
  }
}
