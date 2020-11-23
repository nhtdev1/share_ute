
part of 'document_info_bloc.dart';


abstract class DocumentInfoEvent extends Equatable{
  const DocumentInfoEvent(this.post);

  final Post post;

  @override
  // TODO: implement props
  List<Object> get props => [post];
}


class DocumentInfoChanged extends DocumentInfoEvent{
  DocumentInfoChanged(Post post) : super(post);
}

class DocumentInfoLikeRequested extends DocumentInfoEvent{
  DocumentInfoLikeRequested(Post post) : super(post);
}

class DocumentInfoUnLikeRequested extends DocumentInfoEvent{
  DocumentInfoUnLikeRequested(Post post) : super(post);
}

class DocumentInfoDisLikeRequested extends DocumentInfoEvent{
  DocumentInfoDisLikeRequested(Post post) : super(post);
}

class DocumentInfoUnDisLikeRequested extends DocumentInfoEvent{
  DocumentInfoUnDisLikeRequested(Post post) : super(post);
}