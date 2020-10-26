import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:share_ute/models/file.dart';
import 'package:share_ute/widgets/folder_sortby_bottom_sheet.dart';
import 'package:share_ute/repositories/folder_repository.dart';

import '../models/file.dart';

class FolderBloc {
  StreamController _listDataController = new StreamController();
  StreamController _sortTypeController = new StreamController();

  List<File> _data = new List<File>();
  FolderRepository _repository = new FolderRepository();

  SORT_BY _curSortType;
  bool _isIncrement;

  Stream get listDataStream => _listDataController.stream;
  Stream get sortTypeStream => _sortTypeController.stream;
  SORT_BY get curSortType => _curSortType;
  bool get isIncrement => _isIncrement;
  int get getLength => _data.length;
  List<File> get getData => _data;

  void init(
      {List<File> data = null, SORT_BY type = null, bool isIncrement = null}) {
    data == null ? _data = _repository.getFileData() : _data = data;
    _listDataController.sink.add(true);

    type == null ? _curSortType = SORT_BY.Name : _curSortType = type;
    isIncrement == null ? _isIncrement = true : _isIncrement = isIncrement;
    _sortTypeController.sink.add(true);
  }

  void dispose() {
    _listDataController.close();
    _sortTypeController.close();
  }

  /// Lấy danh sách con của 1 folder thông qua id của folder đó
  List<File> getChildOf({@required String folderId}) {
    //TODO: Xử lí khi có dữ liệu
    return _repository.getFileData();
  }

  bool createFolder(String fileName){
    _data.add(_repository.createFile("folder", fileName, "", true, DateTime.now()));
    _listDataController.sink.add(true);
    return true;
  }

  void sort(SORT_BY sortBy, bool isIncrement) {
    _curSortType = sortBy;
    _isIncrement = isIncrement;
    _data = _sorted(_data, sortBy, isIncrement);

    _sortTypeController.sink.add(true);
    _listDataController.sink.add(true);
  }

  List<File> _sorted(List<File> data, SORT_BY type, bool isIncrement) {
    for (int i = 0; i < data.length; i++) {
      for (int j = 0; j < data.length - i - 1; j++) {
        if (_isGreaterThan(data[j], data[j + 1], type)) {
          var temp = data[j + 1];
          data[j + 1] = data[j];
          data[j] = temp;
        }
      }
    }
    return isIncrement ? data : List.from(data.reversed);
  }


  bool _isGreaterThan(File a, File b, SORT_BY type) {
    /// Folder đứng trước file
    if (a.isFolder && !b.isFolder) return false;
    if (!a.isFolder && b.isFolder) return true;

    /// Nếu cùng loại file hoặc folder
    switch (type) {
      case SORT_BY.Name:
        return a.fileName.compareTo(b.fileName) > 0;
      case SORT_BY.LastModifiedByMe:
        return a.dateCreated.compareTo(b.dateCreated) > 0;
      case SORT_BY.LastModified:
        return a.dateCreated.compareTo(b.dateCreated) > 0;
      case SORT_BY.LastOpenedByMe:
        return a.dateCreated.compareTo(b.dateCreated) > 0;
      case SORT_BY.StorageUsed:
        return a.dateCreated.compareTo(b.dateCreated) > 0;
    }
    return false;
  }
}
