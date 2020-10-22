import 'package:flutter/material.dart';

enum SORT_BY {
  Name,
  LastModified,
  LastModifiedByMe,
  LastOpenedByMe,
  StorageUsed,
}

class FolderSortByBottomSheet extends StatelessWidget {
  final IconData dataIcon;
  final SORT_BY curSelection;
  const FolderSortByBottomSheet({Key key, this.dataIcon, this.curSelection})
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
                  "Sort by",
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
                onTap: (){print("Name");},
                child: Container(
                    width: size.width-5,
                    decoration: curSelection==SORT_BY.Name? BoxDecoration(
                        color: Color(0xffC4E2F4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30))) : null,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        curSelection == SORT_BY.Name
                            ? Icon(
                          dataIcon,
                          color: Colors.blue[900],
                          size: 20,
                        )
                            : Icon(
                          dataIcon,
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Name",
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
                onTap: (){print("last modified");},
                child: Container(
                    width: size.width-5,
                    decoration: curSelection==SORT_BY.LastModified? BoxDecoration(
                        color: Color(0xffC4E2F4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30))) : null,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        curSelection == SORT_BY.LastModified
                            ? Icon(
                          dataIcon,
                          color: Colors.blue[900],
                          size: 20,
                        )
                            : Icon(
                          dataIcon,
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Last Modified",
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
                onTap: (){print("last modified by me");},
                child: Container(
                    width: size.width-5,
                    decoration: curSelection==SORT_BY.LastModifiedByMe? BoxDecoration(
                        color: Color(0xffC4E2F4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30))) : null,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        curSelection == SORT_BY.LastModifiedByMe
                            ? Icon(
                          dataIcon,
                          color: Colors.blue[900],
                          size: 20,
                        )
                            : Icon(
                          dataIcon,
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Last Modified By Me",
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
                onTap: (){print("last opened by me");},
                child: Container(
                    width: size.width-5,
                    decoration: curSelection==SORT_BY.LastOpenedByMe? BoxDecoration(
                        color: Color(0xffC4E2F4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30))) : null,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        curSelection == SORT_BY.LastOpenedByMe
                            ? Icon(
                          dataIcon,
                          color: Colors.blue[900],
                          size: 20,
                        )
                            : Icon(
                          dataIcon,
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Last Opened By Me",
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
                onTap: (){print("Storage used");},
                child: Container(
                    width: size.width-5,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: curSelection==SORT_BY.StorageUsed? BoxDecoration(
                        color: Color(0xffC4E2F4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30))) : null,
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Row(
                      children: [
                        curSelection == SORT_BY.StorageUsed
                            ? Icon(
                          dataIcon,
                          color: Colors.blue[900],
                          size: 20,
                        )
                            : Icon(
                          dataIcon,
                          color: Colors.transparent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Storage Used",
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
}
