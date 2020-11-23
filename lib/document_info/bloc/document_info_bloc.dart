import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/notification/notification.dart';

part 'document_info_event.dart';

part 'document_info_state.dart';

class DocumentInfoBloc extends Bloc<DocumentInfoEvent, DocumentInfoState> {
  DocumentInfoBloc({
    @required PostRepository postRepository,
    @required NotificationCubit notificationCubit,
  })  : assert(postRepository != null),
        _postRepository = postRepository,
        super(const DocumentInfoState.unknown()) {
    _postRepository.post(notificationCubit.state.post.postID).listen((post) {
      add(DocumentInfoChanged(post));
    });
  }

  final PostRepository _postRepository;

  StreamSubscription<Post> _postSubscription;

  @override
  Future<void> close() {
    _postSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<DocumentInfoState> mapEventToState(DocumentInfoEvent event) async* {
    if(event is DocumentInfoChanged){
      yield _mapDocumentInfoChangedState(event);
    }
    else if (event is DocumentInfoLikeRequested) {
      yield _mapDocumentInfoLikeRequestedToState(event);
    }
  }

  DocumentInfoState _mapDocumentInfoLikeRequestedToState(
    DocumentInfoLikeRequested event,
  ) {
    return DocumentInfoState.like(event.post);
  }

  DocumentInfoState _mapDocumentInfoChangedState(
      DocumentInfoChanged event,
      ) {
    return DocumentInfoState.postChanged(event.post);
  }
}
