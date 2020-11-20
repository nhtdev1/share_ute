import 'package:equatable/equatable.dart';

class File extends Equatable {
  const File({
    this.path,
    this.fileName,
    this.fileExtension,
    this.fileSize,
  });

  final String path;
  final String fileName;
  final String fileExtension;
  final String fileSize;

  @override
  // TODO: implement props
  List<Object> get props => [
        path,
        fileName,
        fileExtension,
        fileSize,
      ];

  static const empty = File(
    path: '',
    fileName: '',
    fileExtension: '',
    fileSize: '',
  );

  File copyWith({
    String path,
    String fileName,
    String fileExtension,
    String fileSize,
  }) {
    return File(
      path: path ?? this.path,
      fileName: fileName ?? this.fileName,
      fileExtension: fileExtension ?? this.fileExtension,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  bool get isEmpty => path.isEmpty;

  bool get isNotEmpty => path.isNotEmpty;
}
