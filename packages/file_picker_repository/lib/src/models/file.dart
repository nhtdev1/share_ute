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

  bool get isNotEmpty => path.isNotEmpty;
}
