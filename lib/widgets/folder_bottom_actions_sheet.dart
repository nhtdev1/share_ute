import 'package:flutter/material.dart';
import 'package:share_ute/blocs/folder_bloc.dart';
import 'package:share_ute/models/folder.dart';
import 'package:share_ute/widgets/folder_components/dialogs.dart';
import 'package:share_ute/widgets/folder_components/popup_input.dart';

import 'folder_components/action_type.dart';

class FolderBottomActionsSheet extends StatefulWidget {
  final IconData iconData;
  final Color iconColor;
  final String itemId;
  final FolderBloc bloc;

  /// Thuộc tính này không còn sử dụng
  /// Nhưng expand_folder_page có sử dụng
  /// Nên tạm thời để lại để không lỗi
  final String title;

  const FolderBottomActionsSheet(
      {Key key,
      this.iconData,
      this.iconColor,
      this.itemId,
      this.bloc,
      this.title})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FolderBottomActionsSheet();
  }
}

class _FolderBottomActionsSheet extends State<FolderBottomActionsSheet> {
  var paddingLeft = 15.0;
  var paddingTop = 10.0;
  var paddingBot = 10.0;

  @override
  Widget build(BuildContext context) {
    Folder myFile = widget.bloc.getItem(widget.itemId);
    var size = MediaQuery.of(context).size;

    void rename(value) {
      widget.bloc.updateItem(id: myFile.id, name: value);
    }

    /// View
    return Container(
      child: Wrap(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: paddingLeft, top: paddingTop + 5, bottom: paddingBot),
                child: Row(
                  children: [
                    Icon(
                      widget.iconData,
                      color: widget.iconColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 0.8 * size.width,
                      child: Text(
                        myFile.fileName,
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
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: paddingLeft, top: paddingTop, bottom: paddingBot),
                child: GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Đổi tên",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (_) => PopupInput(
                                title: "Nhập tên mới",
                                hintText: "...",
                                text: myFile.fileName,
                                action: ACTION_TYPE.CANCEL_RENAME,
                                callback: rename,
                              ));
                    }),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: paddingLeft, top: paddingTop, bottom: paddingBot),
                child: GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Icons.restore_from_trash,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Xóa",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    MyDialogs.showDialogConfirm(
                        context,
                        "DO YOU WANT REMOVE IT?",
                        ACTION_TYPE.NO_YES,
                        widget.bloc.removeItem,
                        widget.itemId);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
