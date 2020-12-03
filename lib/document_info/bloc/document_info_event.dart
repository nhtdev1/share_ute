part of 'document_info_bloc.dart';

abstract class DocumentInfoEvent extends Equatable {
  const DocumentInfoEvent();

  @override
  List<Object> get props => [];
}

class DocumentInfoChanged extends DocumentInfoEvent {
  const DocumentInfoChanged(this.post);

  final Post post;

  @override
  List<Object> get props => [post];
}

class DocumentInfoLikeRequested extends DocumentInfoEvent {}

class DocumentInfoDisLikeRequested extends DocumentInfoEvent {}
