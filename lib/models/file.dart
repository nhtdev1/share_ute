class File{
  final String fileType;

  final String fileName;

  final String fileImage;

  final bool isFolder;

  DateTime dateCreated;

  File({
   this.fileType,
   this.fileName,
   this.fileImage,
   this.isFolder,
   this.dateCreated});
}