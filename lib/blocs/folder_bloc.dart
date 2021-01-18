import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:share_ute/models/folder.dart';
import 'package:share_ute/widgets/folder_sortby_bottom_sheet.dart';
import 'package:share_ute/repositories/folder_repository.dart';

class FolderBloc {
  StreamController _listDataController = new StreamController();
  StreamController _sortTypeController = new StreamController();

  List<Folder> _data = List<Folder>();
  FolderRepository _repository = FolderRepository();

  SORT_BY _curSortType;
  bool _isIncrement;

  Stream get listDataStream => _listDataController.stream;
  Stream get sortTypeStream => _sortTypeController.stream;
  SORT_BY get curSortType => _curSortType;
  bool get isIncrement => _isIncrement;
  int get getLength => _data.length;
  List<Folder> get getData => _data;

  void init({List<Folder> data, SORT_BY type, bool isIncrement}) {
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
  List<Folder> getChildOf({@required String folderId}) {
    // ignore: todo
    //TODO: Xử lí khi có dữ liệu
    return _repository.getFileData();
  }

  /// Hàm tạo một folder mới
  bool createFolder(String fileName) {
    if (fileName == "") {
      _listDataController.sink.addError("File Name Not Allow");
      _listDataController.sink.add(false);
      return false;
    }
    _data.add(
        _repository.createFolder("folder", fileName, "", true, DateTime.now()));
    _listDataController.sink.add(true);
    return true;
  }

  /// Hàm lấy thuộc tính 1 file/folder
  Folder getItem(String id) {
    for (var item in _data) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  /// Hàm câp nhật 1 file/folder
  // ignore: missing_return
  bool updateItem({
    @required String id,
    bool isStarred,
    bool isSharing,
    String name,
  }) {
    for (var item in _data) {
      if (item.id == id) {
        item.isSharing = isSharing == null ? item.isSharing : isSharing;
        item.isAddStarted = isStarred == null ? item.isAddStarted : isStarred;
        if (name != null && name != "") {
          item.fileName = name;
          _listDataController.sink.add(true);
        }
      }
    }
  }

  /// Hàm xóa 1 file/folder
  bool removeItem(String id) {
    for (var item in _data) {
      if (item.id == id) {
        _data.remove(item);
        _listDataController.sink.add(true);
        return true;
      }
    }
    return false;
  }

  List<String> indexItemChose = new List<String>();
  void selected(String id) {
    if (indexItemChose.contains(id)) {
      indexItemChose.remove(id);
    } else {
      indexItemChose.add(id);
    }
    _listDataController.sink.add(true);
  }

  /// Hàm sắp xếp
  void sort(SORT_BY sortBy, bool isIncrement) {
    _curSortType = sortBy;
    _isIncrement = isIncrement;
    _data = _sorted(_data, sortBy, isIncrement);

    _sortTypeController.sink.add(true);
    _listDataController.sink.add(true);
  }

  /// Thuật toán bubble sort
  List<Folder> _sorted(List<Folder> data, SORT_BY type, bool isIncrement) {
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

  bool _isGreaterThan(Folder a, Folder b, SORT_BY type) {
    /// Folder đứng trước file
    if (a.hasChild && !b.hasChild) return false;
    if (!a.hasChild && b.hasChild) return true;

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
