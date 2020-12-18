part of 'document_comment_bloc.dart';

abstract class DocumentCommentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DocumentCommentFetched extends DocumentCommentEvent {}

class DocumentCommentRefreshed extends DocumentCommentEvent {}

class DocumentCommentJustAdded extends DocumentCommentEvent {}
