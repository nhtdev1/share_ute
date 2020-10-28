import 'package:flutter/material.dart';
import 'package:share_ute/blocs/folder_bloc.dart';
import 'package:share_ute/models/file.dart';
import 'file:///D:/_STUDY/2020-2021/HK_I/_TLCN/share_ute/lib/widgets/folder_components/dialogs.dart';
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
  var PADDING_LEFT = 15.0;
  var PADDING_TOP = 10.0;
  var PADDING_BOT = 10.0;

  @override
  Widget build(BuildContext context) {
    File myFile = widget.bloc.getItem(widget.itemId);
    var size = MediaQuery.of(context).size;
    void addStarred() {
      setState(() {
        myFile.isAddStarted = !myFile.isAddStarted;
      });
      widget.bloc.updateItem(id: myFile.id, isStarred: myFile.isAddStarted);
    }

    void sharing() {
      setState(() {
        myFile.isSharing = !myFile.isSharing;
      });
      widget.bloc.updateItem(id: myFile.id, isSharing: myFile.isSharing);
    }

    void rename(value) {
      widget.bloc.updateItem(id: myFile.id, name: value);
    }

    /// View
    return Container(
      child: new Wrap(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: PADDING_LEFT,
                    top: PADDING_TOP + 5,
                    bottom: PADDING_BOT),
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
          Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: PADDING_LEFT, top: PADDING_TOP, bottom: PADDING_BOT),
                child: GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Share",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                  onTap: () {},
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(
                      left: PADDING_LEFT,
                      top: PADDING_TOP,
                      bottom: PADDING_BOT),
                  child: GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          myFile.isAddStarted ? Icons.star : Icons.star_border,
                          color:
                              myFile.isAddStarted ? Colors.yellow : Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          myFile.isAddStarted
                              ? "Remove from Starred"
                              : "Add to starred",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                    onTap: () => addStarred(),
                  ))
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 0.5,
            indent: 0.1 * size.width,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(
                      left: PADDING_LEFT,
                      top: PADDING_TOP,
                      bottom: PADDING_BOT),
                  child: GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          myFile.isSharing ? Icons.link : Icons.link_off,
                          color: myFile.isSharing ? Colors.green : Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          myFile.isSharing
                              ? "Link sharing on"
                              : "Link sharing off",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )
                      ],
                    ),
                    onTap: () => sharing(),
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: PADDING_LEFT, top: PADDING_TOP, bottom: PADDING_BOT),
                child: Row(
                  children: [
                    Icon(
                      Icons.content_copy,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Copy link",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 0.5,
            indent: 0.1 * size.width,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: PADDING_LEFT, top: PADDING_TOP, bottom: PADDING_BOT),
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
                          "Rename",
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
                                title: "Rename Folder",
                                hintText: "Untitled folder",
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
                    left: PADDING_LEFT, top: PADDING_TOP, bottom: PADDING_BOT),
                child: Row(
                  children: [
                    Icon(
                      Icons.color_lens,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Change color",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                    left: PADDING_LEFT, top: PADDING_TOP, bottom: PADDING_BOT),
                child: Row(
                  children: [
                    Icon(
                      Icons.details,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Details & activity",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                    left: PADDING_LEFT, top: PADDING_TOP, bottom: PADDING_BOT),
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
                        "Remove",
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
