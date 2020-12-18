import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:comment_repository/comment_repository.dart';
import 'package:meta/meta.dart';
import 'package:share_ute/comment_notification/comment_notification.dart';

part 'document_comment_event.dart';
part 'document_comment_state.dart';

const _commentLimit = 20;

class DocumentCommentBloc
    extends Bloc<DocumentCommentEvent, DocumentCommentState> {
  DocumentCommentBloc({
    @required CommentRepository commentRepository,
    @required CommentNotificationCubit commentNotificationCubit,
  })  : _commentNotificationCubit = commentNotificationCubit,
        super(DocumentCommentState()) {
    _commentSubscription =
        _commentNotificationCubit.listen((commentNotificationState) {
      commentList = commentNotificationState.comments;
      add(DocumentCommentRefreshed());
    });
  }

  final CommentNotificationCubit _commentNotificationCubit;
  List<Comment> commentList = [];
  StreamSubscription<CommentNotificationState> _commentSubscription;

  @override
  Future<void> close() {
    _commentSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<DocumentCommentState> mapEventToState(
      DocumentCommentEvent event) async* {
    if (event is DocumentCommentFetched) {
      yield await _mapDocumentCommentFetchedToState();
    } else if (event is DocumentCommentRefreshed) {
      yield await _mapDocumentCommentRefreshedToState();
    }
  }

  Future<DocumentCommentState> _mapDocumentCommentRefreshedToState() async {
    final comments = _fetchComments(state.comments.length);
    return comments.isEmpty
        ? state.copyWith(hasReachedMax: true)
        : state.copyWith(
            status: DocumentCommentStatus.success,
            comments: List.of(state.comments)..addAll(comments),
            hasReachedMax: _hasReachedMax(comments.length),
          );
  }

  Future<DocumentCommentState> _mapDocumentCommentFetchedToState() async {
    if (state.hasReachedMax) return state;
    if (state.status == DocumentCommentStatus.initial) {
      final comments = _fetchComments();
      return state.copyWith(
        status: DocumentCommentStatus.success,
        comments: comments,
        hasReachedMax: _hasReachedMax(comments.length),
      );
    }

    final comments = _fetchComments(state.comments.length);
    return comments.isEmpty
        ? state.copyWith(hasReachedMax: true)
        : state.copyWith(
            status: DocumentCommentStatus.success,
            comments: List.of(state.comments)..addAll(comments),
            hasReachedMax: _hasReachedMax(comments.length),
          );
  }

  bool _hasReachedMax(int commentsCount) =>
      commentsCount < _commentLimit ? true : false;

  List<Comment> _fetchComments([int startIndex = 0]) {
    commentList = _commentNotificationCubit.state.comments;
    if (startIndex + _commentLimit <= commentList.length) {
      return commentList
          .getRange(startIndex, startIndex + _commentLimit)
          .toList();
    } else if (startIndex < commentList.length) {
      return commentList.getRange(startIndex, commentList.length).toList();
    } else {
      return [];
    }
  }

//verriding transform allows us to transform the Stream before mapEventToState is called.
// This allows for operations like distinct(), debounceTime(), etc... to be applied.
  @override
  Stream<Transition<DocumentCommentEvent, DocumentCommentState>>
      transformEvents(
    Stream<DocumentCommentEvent> events,
    TransitionFunction<DocumentCommentEvent, DocumentCommentState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 100)),
      transitionFn,
    );
  }
}
