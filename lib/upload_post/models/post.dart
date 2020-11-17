import 'package:equatable/equatable.dart';
import 'package:share_ute/upload_post/models/models.dart';

class Post extends Equatable {
  const Post({
    this.postAccessModifiers = const AccessModifiers.public(),
    this.postTitle = const Title.pure(),
    this.file = const File(),
    this.postTags = const Tags.pure(),
  });

  final AccessModifiers postAccessModifiers;
  final Title postTitle;
  final File file;

  final Tags postTags;

  Post copyWith({
    AccessModifiers postAccessModifiers,
    Title postTitle,
    File file,
    Tags postTags,
  }) {
    return Post(
      postAccessModifiers: postAccessModifiers ?? this.postAccessModifiers,
      postTitle: postTitle ?? this.postTitle,
      file: file ?? this.file,
      postTags: postTags ?? this.postTags,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        postAccessModifiers,
        postTitle,
        file,
        postTags,
      ];

  bool get isNotEmpty => postTitle.isNotEmpty && file.isNotEmpty;
}
