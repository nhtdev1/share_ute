import 'package:share_ute/models/folder.dart';

import '../models/folder.dart';

class FolderRepository {
  static final folderList = [
    Folder(
        hasChild: true,
        fileName: "Điện, điện tử",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Điện tử - viễn thông",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kỹ thuật máy tính",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Điều khiển & tự động hóa",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kỹ thuật y sinh",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Hệ thống nhúng & IoT",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Robot & trí tuệ nhân tạo",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Chế tạo máy",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Cơ điện tử",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Cơ khí",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kỹ thuật công nghiệp",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kỹ nghệ gỗ & nội thất",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Công trình xây dựng",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Xây dựng công trình GT",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Hệ thống kỹ thuật CTXD",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Ô tô",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Nhiệt",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Năng lượng tái tạo",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Công nghệ thông tin",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kỹ thuật dữ liệu",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Quản lý công nghiệp",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kế toán",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Thương mại điện tử",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Logistics & quản lý chuỗi cung ứng",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kinh doanh Quốc tế",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Công nghệ may",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kỹ thuật in",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Thiết kế đồ họa",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kiến trúc",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Kiến trúc nội thất",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Công nghệ vật liệu",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "CNKT môi trường",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "CN thực phẩm",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "CNKT hóa học",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Quản trị NH và DV ăn uống",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Thiết kế thời trang",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Sư phạm tiếng Anh",
        fileType: "folder",
        dateCreated: DateTime.now()),
    Folder(
        hasChild: true,
        fileName: "Ngôn ngữ Anh",
        fileType: "folder",
        dateCreated: DateTime.now()),
  ];

  List<Folder> getFileData() {
    var id = 0;
    List<Folder> myFiles = [];
    for (var item in folderList) {
      item.id = id.toString();
      item.isAddStarted = false;
      item.isSharing = false;
      id += 1;
      myFiles.add(item);
    }
    return myFiles;
  }

  Folder createFolder(fileType, fileName, fileImg, hasChild, datCreate) {
    Folder file = Folder(
        fileType: fileType,
        fileName: fileName,
        fileImage: fileImg,
        hasChild: hasChild,
        dateCreated: datCreate);
    return file;
  }
}
