import 'package:flutter/material.dart';

class FolderBottomActionsSheet extends StatefulWidget {
  final IconData iconData;
  final Color iconColor;
  final String title;

  const FolderBottomActionsSheet(
      {Key key, this.iconData, this.iconColor, this.title})
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
    var size = MediaQuery.of(context).size;
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
                        widget.title,
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
                      Icons.star_border,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add to starred",
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
                child: Row(
                  children: [
                    Icon(
                      Icons.link_off,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Link sharing off",
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
