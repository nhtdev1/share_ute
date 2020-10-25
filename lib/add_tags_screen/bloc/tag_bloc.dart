import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:share_ute/add_tags_screen/add_tags_screen.dart';

part 'tag_event.dart';

part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc() : super(const TagState());

  @override
  Stream<TagState> mapEventToState(TagEvent event) async* {
    if (event is TagNameChanged) {
      yield _mapTagNameChangedToState(event, state);
    }
  }

  TagState _mapTagNameChangedToState(
    TagNameChanged event,
    TagState state,
  ) {
    final tagName = TagName.dirty(event.tagName);
    return state.copyWith(
        tagName: tagName, status: Formz.validate([state.tagName]));
  }
}
