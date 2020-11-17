import 'package:equatable/equatable.dart';
import 'package:share_ute/upload_post/models/models.dart';


class File extends Equatable {
  const File({
    this.path = '',
    this.fileName = const Name.pure(),
    this.fileExtension = const Extension.pure(),
    this.fileSize = const Size.pure(),
  });

  final String path;
  final Name fileName;
  final Extension fileExtension;
  final Size fileSize;

  @override
  // TODO: implement props
  List<Object> get props => [path, fileName, fileExtension, fileSize];

  File copyWith({
    String path,
    Name fileName,
    Extension fileExtension,
    Size fileSize,
  }) {
    return File(
      path: path ?? this.path,
      fileName: fileName ?? this.fileName,
      fileExtension: fileExtension ?? this.fileExtension,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  bool get isNotEmpty => path.trim() != '';
}
