import 'package:share_ute/models/file.dart';

import '../models/file.dart';

class FolderRepository {
  static final folderList = [
    File(
        isFolder: true,
        fileName: "Điện, điện tử",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Điện tử - viễn thông",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kỹ thuật máy tính",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Điều khiển & tự động hóa",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kỹ thuật y sinh",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Hệ thống nhúng & IoT",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Robot & trí tuệ nhân tạo",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Chế tạo máy",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Cơ điện tử",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Cơ khí",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kỹ thuật công nghiệp",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kỹ nghệ gỗ & nội thất",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Công trình xây dựng",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Xây dựng công trình GT",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Hệ thống kỹ thuật CTXD",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Ô tô",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Nhiệt",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Năng lượng tái tạo",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Công nghệ thông tin",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kỹ thuật dữ liệu",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Quản lý công nghiệp",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kế toán",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Thương mại điện tử",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Logistics & quản lý chuỗi cung ứng",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kinh doanh Quốc tế",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Công nghệ may",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kỹ thuật in",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Thiết kế đồ họa",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kiến trúc",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Kiến trúc nội thất",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Công nghệ vật liệu",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "CNKT môi trường",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "CN thực phẩm",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "CNKT hóa học",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Quản trị NH và DV ăn uống",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Thiết kế thời trang",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Sư phạm tiếng Anh",
        fileType: "folder",
        dateCreated: DateTime.now()),
    File(
        isFolder: true,
        fileName: "Ngôn ngữ Anh",
        fileType: "folder",
        dateCreated: DateTime.now()),
  ];

  List<File> getFileData() {
    var id = 0;
    List<File> myFiles = new List<File>();
    for (var item in folderList) {
      item.id = id.toString();
      item.isAddStarted = false;
      item.isSharing = false;
      id += 1;
      myFiles.add(item);
    }
    return myFiles;
  }

  File createFile(fileType, fileName, fileImg, isFolder, datCreate) {
    File file = new File(
        fileType: fileType,
        fileName: fileName,
        fileImage: fileImg,
        isFolder: isFolder,
        dateCreated: datCreate);
    return file;
  }

  // bool editFile() {}
  // bool deleteFile() {}
  // bool getFile() {}
}
