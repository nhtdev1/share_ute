import 'package:flutter/material.dart';
import 'package:share_ute/blocs/folder_bloc.dart';

enum SORT_BY {
  Name,
  LastModified,
  LastModifiedByMe,
  LastOpenedByMe,
  StorageUsed,
}

extension SORT_BY_EX on SORT_BY {
  String get convertToString {
    switch (this) {
      case SORT_BY.Name:
        return 'name';
      case SORT_BY.LastModified:
        return "last modified";
      case SORT_BY.LastModifiedByMe:
        return "last modified by me";
      case SORT_BY.StorageUsed:
        return "storage used";
      case SORT_BY.LastOpenedByMe:
        return "last opened by me";
      default:
        return "";
    }
  }
}

class FolderSortByBottomSheet extends StatelessWidget {
  @required
  final context;
  @required
  final bool isIncrement;
  @required
  final SORT_BY curSortSelection;
  @required
  final FolderBloc bloc;
  const FolderSortByBottomSheet(
      {Key key,
      this.context,
      this.isIncrement,
      this.curSortSelection,
      this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: new Wrap(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 15, bottom: 10),
                child: Text(
                  "Sắp xếp theo",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
            ],
          ),
          Divider(
            thickness: 0.5,
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  sortBy(SORT_BY.Name, isIncrement);
                },
                child: Container(
                    width: size.width - 5,
                    decoration: curSortSelection == SORT_BY.Name
                        ? BoxDecoration(
                            color: Color(0xffC4E2F4),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)))
                        : null,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        curSortSelection == SORT_BY.Name
                            ? Icon(
                                isIncrement
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.blue[900],
                                size: 20,
                              )
                            : Icon(
                                isIncrement
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.transparent,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Tên",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    )),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  sortBy(SORT_BY.LastModified, isIncrement);
                },
                child: Container(
                    width: size.width - 5,
                    decoration: curSortSelection == SORT_BY.LastModified
                        ? BoxDecoration(
                            color: Color(0xffC4E2F4),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)))
                        : null,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        curSortSelection == SORT_BY.LastModified
                            ? Icon(
                                isIncrement
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.blue[900],
                                size: 20,
                              )
                            : Icon(
                                isIncrement
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.transparent,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Lần chỉnh sửa cuối",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    )),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  sortBy(SORT_BY.LastOpenedByMe, isIncrement);
                },
                child: Container(
                    width: size.width - 5,
                    decoration: curSortSelection == SORT_BY.LastOpenedByMe
                        ? BoxDecoration(
                            color: Color(0xffC4E2F4),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)))
                        : null,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        curSortSelection == SORT_BY.LastOpenedByMe
                            ? Icon(
                                isIncrement
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.blue[900],
                                size: 20,
                              )
                            : Icon(
                                isIncrement
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.transparent,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Lần mở cuối cùng",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    )),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  sortBy(SORT_BY.StorageUsed, isIncrement);
                },
                child: Container(
                    width: size.width - 5,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: curSortSelection == SORT_BY.StorageUsed
                        ? BoxDecoration(
                            color: Color(0xffC4E2F4),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)))
                        : null,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        curSortSelection == SORT_BY.StorageUsed
                            ? Icon(
                                isIncrement
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.blue[900],
                                size: 20,
                              )
                            : Icon(
                                isIncrement
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.transparent,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Kích thước",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  void sortBy(SORT_BY typeChoose, bool isIncrement) {
    bloc.sort(typeChoose,
        curSortSelection == typeChoose ? !isIncrement : isIncrement);
    Navigator.pop(context);
  }
}
