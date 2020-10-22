import 'package:flutter/material.dart';
import 'package:share_ute/widgets/folder_bottom_actions_sheet.dart';
import 'package:share_ute/widgets/folder_create_bottom_sheet.dart';
import 'package:share_ute/widgets/folder_sortby_bottom_sheet.dart';
import 'package:share_ute/models/file.dart';

class MyFolderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<File> data = new List<File>();
    File file = new File(
        isFolder: true,
        fileName: "Công Nghệ Thông Tin",
        fileType: "folder",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: true,
        fileName: "Cơ Khí Chế Tạo Máy",
        fileType: "folder",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: true,
        fileName: "Công Nghệ Thực Phẩm",
        fileType: "folder",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: true,
        fileName: "Kinh Tế",
        fileType: "folder",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: true,
        fileName: "Trí Tuệ Nhân Tạo",
        fileType: "folder",
        dateCreated: DateTime.now());
    data.add(file);

    return FolderPage(
      isChild: false,
      data: data,
    );
  }
}

class FolderPage extends StatefulWidget {
  /// False nếu đây là folder ban đầu
  final bool isChild;

  /// Nếu là folder con
  final String folderTitle;
  final List<File> data;
  const FolderPage({Key key, this.isChild = false, this.folderTitle, this.data})
      : super(key: key);

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  var isListView = true;
  var sortIncrement = true;
  SORT_BY curSelection = SORT_BY.Name;

  List<File> getFileData() {
    List<File> data = new List<File>();
    File file = new File(
        isFolder: true,
        fileName: "De thi CNTT HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: true,
        fileName: "De CMK HK2 2019",
        fileType: "word",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: true,
        fileName: "Kiem Tra Oto HK1 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: false,
        fileName: "De thi Co Khi Che Tao May HK2 2019 99999 9999999 9999 9999",
        fileType: "excel",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: false,
        fileName: "De thi CN May HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: false,
        fileName: "De thi Kinh Te HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: false,
        fileName: "De thi Xay Dung HK2 2019",
        fileType: "word",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: false,
        fileName: "De thi CNTT HK2 2019",
        fileType: "word",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: false,
        fileName: "De thi Dien-Dien Tu HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: false,
        fileName: "De thi CNTT HK2 2019",
        fileType: "word",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: false,
        fileName: "De thi Dien-Dien Tu HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        isFolder: false,
        fileName: "De thi CNTT HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Create new folder",
        backgroundColor: Colors.white,
        elevation: 2,
        child: Icon(
          Icons.add,
          color: Colors.blue[900],
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (builderContext) => FolderCreateBottomSheet());
        },
      ),
      appBar: !widget.isChild
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Container(
                margin: EdgeInsets.only(top: 5),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    height: 50,
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          icon: GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {},
                          ),
                          suffixIcon: GestureDetector(
                            child: Container(
                              height: 5,
                              width: 5,
                              margin: EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.person),
                              ),
                            ),
                            onTap: () {
                              print("Icon click");
                            },
                          )),
                    ),
                  ),
                ),
              ),
            )
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              leading: GestureDetector(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                widget.folderTitle,
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              actions: [
                GestureDetector(
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0.025 * size.height),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 0.05 * size.width, right: 0.05 * size.width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Text("name"),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (builderContext) =>
                                FolderSortByBottomSheet(
                                    curSelection: curSelection,
                                    dataIcon: sortIncrement
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward));
                      },
                    ),
                    GestureDetector(
                      child: Icon(
                        sortIncrement
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        size: 0.035 * size.width,
                      ),
                      onTap: () {
                        setState(() {
                          sortIncrement = !sortIncrement;
                        });
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  child: isListView
                      ? Icon(Icons.format_list_bulleted)
                      : Icon(Icons.grid_on),
                  onTap: () {
                    setState(() {
                      isListView = !isListView;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.02 * size.height),
          ),
          isListView
              ? Container(
                  height: 0.8 * size.height,
                  width: size.width,
                  child: new ListView.builder(
                      itemCount: widget.data.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return index < widget.data.length
                            ? _mediaListItem(
                                widget.data[index].fileName,
                                widget.data[index].isFolder
                                    ? Colors.grey[700]
                                    : Colors.blue[900],
                                Colors.transparent,
                                widget.data[index].dateCreated
                                    .toString()
                                    .split(' ')[0],
                                widget.data[index].isFolder
                                    ? Icons.folder
                                    : Icons.insert_drive_file,
                                isFolder: widget.data[index].isFolder)
                            : SizedBox(
                                height: 15,
                              );
                      }),
                )
              : Container(
                  height: 0.8 * size.height,
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: widget.data.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return _mediaGridItem(
                            widget.data[index].fileName,
                            widget.data[index].isFolder
                                ? Colors.grey[700]
                                : Colors.blue[900],
                            Colors.transparent,
                            widget.data[index].dateCreated.toString(),
                            widget.data[index].isFolder
                                ? Icons.folder
                                : Icons.insert_drive_file,
                            isFolder: widget.data[index].isFolder);
                      }),
                )
        ],
      ),
    );
  }

  Widget _mediaListItem(String title, Color iconColor, Color accent,
      String meta, IconData mediaIcon,
      {bool isFolder = false, bool isChoose = false}) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: 0.04 * size.width,
        top: 0.005 * size.height,
        bottom: 0.005 * size.height,
      ),
      margin: EdgeInsets.only(
        bottom: 0.01 * size.height,
      ),
      decoration: isChoose
          ? BoxDecoration(
              color: Color(0xffC4E2F4),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0)))
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6.8),
            ),
            child: Padding(
                padding: EdgeInsets.all(0.015 * size.width),
                child: GestureDetector(
                  child: Icon(
                    mediaIcon,
                    size: 0.08 * size.width,
                    color: iconColor,
                  ),
                  onTap: () {
                    if (isFolder) _goToChild(title, getFileData());
                  },
                )),
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(left: 0.025 * size.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 0.7 * size.width,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 0.005 * size.height,
                  ),
                  Text(
                    meta,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              isFolder
                  ? _goToChild(title, getFileData())
                  : print("Click File");
            },
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 0.03 * size.width),
                child: GestureDetector(
                  child: Icon(Icons.more_vert),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (builderContext) => FolderBottomActionsSheet(
                              iconData: mediaIcon,
                              iconColor: iconColor,
                              title: title,
                            ));
                  },
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _mediaGridItem(String title, Color iconColor, Color accent,
      String meta, IconData mediaIcon,
      {bool isFolder = false, bool isChoose = false}) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(
          bottom: 0.02 * size.height,
          left: 0.02 * size.width,
          right: 0.02 * size.width,
        ),
        child: Container(
          decoration: isChoose
              ? BoxDecoration(
                  color: Color(0xffC4E2F4),
                  borderRadius: BorderRadius.circular(10.0))
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 0.5 * size.width,
                  height: 0.3 * size.width,
                  decoration: BoxDecoration(
                      color: accent, borderRadius: BorderRadius.circular(15)),
                  child: GestureDetector(
                    child: Icon(
                      mediaIcon,
                      size: 0.3 * size.width,
                      color: iconColor,
                    ),
                    onTap: () {
                      if (isFolder) _goToChild(title, getFileData());
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 0.06 * size.width),
                      width: 0.4 * size.width,
                      child: GestureDetector(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        onTap: () {
                          isFolder
                              ? _goToChild(title, getFileData())
                              : print("Click File");
                        },
                      )),
                  GestureDetector(
                    child: Icon(Icons.more_vert),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builderContext) => FolderBottomActionsSheet(
                                iconData: mediaIcon,
                                iconColor: iconColor,
                                title: title,
                              ));
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }

  void _goToChild(title, data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FolderPage(
        isChild: true,
        folderTitle: title,
        data: data,
      );
    }));
  }
}
