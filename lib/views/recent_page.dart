import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/widgets/folder_bottom_actions_sheet.dart';
import 'package:share_ute/widgets/folder_create_bottom_sheet.dart';
import 'package:share_ute/widgets/folder_sortby_bottom_sheet.dart';
import 'package:share_ute/models/file.dart';

class RecentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<File> data = List<File>();
    File file = File(
        isFolder: false,
        fileName: "Đề thi kỹ thuật lập trình 2020",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = File(
        isFolder: false,
        fileName: "Đề thi toán A1",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = File(
        isFolder: false,
        fileName: "Đề thi Vật lý 1",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = File(
        isFolder: false,
        fileName: "Đề thi Vật lý 2",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = File(
        isFolder: false,
        fileName: "Đề thi xác suất thống kế",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);
    file = File(
        isFolder: false,
        fileName: "Đề thi cơ sở dữ liệu",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = File(
        isFolder: false,
        fileName: "Đề thi OOP",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);
    file = File(
        isFolder: false,
        fileName: "Đề thi mạng máy tính",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);
    file = File(
        isFolder: false,
        fileName: "Đề thi anh văn 1",
        fileType: "pdf",
        dateCreated: DateTime.now());
    file = File(
        isFolder: false,
        fileName: "Đề thi anh văn 2",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    return RecentView(
      isChild: false,
      data: data,
    );
  }
}

class RecentView extends StatefulWidget {
  /// False nếu đây là folder ban đầu
  final bool isChild;

  /// Nếu là folder con
  final String folderTitle;
  final List<File> data;

  const RecentView({Key key, this.isChild = false, this.folderTitle, this.data})
      : super(key: key);

  @override
  _RecentViewState createState() => _RecentViewState();
}

class _RecentViewState extends State<RecentView> {
  bool isListView = true;
  bool sortIncrement = true;
  bool expandableFolder = true;
  SORT_BY curSelection = SORT_BY.Name;
  Widget viewMode;

  @override
  void initState() {
    viewMode = isListView ? _listViewMode() : _gridViewMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Scaffold(
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    GestureDetector(
                      child: isListView
                          ? Icon(
                              const IconData(0xf5ed,
                                  fontFamily: CupertinoIcons.iconFont,
                                  fontPackage: CupertinoIcons.iconFontPackage),
                            )
                          : Icon(
                              const IconData(0xf6e8,
                                  fontFamily: CupertinoIcons.iconFont,
                                  fontPackage: CupertinoIcons.iconFontPackage),
                            ),
                      onTap: () {
                        setState(() {
                          isListView = !isListView;
                          viewMode =
                              isListView ? _listViewMode() : _gridViewMode();
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
              ),
              //isListView?_listViewMode():_gridViewMode()
              viewMode
            ],
          ),
        ));
  }

  Widget _listViewMode() {
    return Container(
      child: ListView.builder(
          itemCount: widget.data.length + 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return index < widget.data.length
                ? _mediaListItem(
                    widget.data[index].fileName,
                    CupertinoColors.systemGrey,
                    Colors.transparent,
                    widget.data[index].dateCreated.toString().split(' ')[0],
                    const IconData(0xf8d2,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    isFolder: widget.data[index].isFolder)
                : const SizedBox(
                    height: 15,
                  );
          }),
    );
  }

  Widget _gridViewMode() {
    return Container(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: widget.data.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return _mediaGridItem(
                widget.data[index].fileName,
                CupertinoColors.secondaryLabel,
                Colors.transparent,
                widget.data[index].dateCreated.toString(),
                const IconData(0xf8d2,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
                isFolder: widget.data[index].isFolder);
          }),
    );
  }

  Widget _mediaListItem(String title, Color iconColor, Color accent,
      String meta, IconData mediaIcon,
      {bool isFolder = false, bool isChoose = false}) {
    final size = MediaQuery.of(context).size;
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
                    if (isFolder)
                      _goToChild(title, File.folderList, isListView);
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
                    "Opened by me " + meta,
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
                  ? _goToChild(title, File.folderList, isListView)
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
                      if (isFolder)
                        _goToChild(title, File.folderList, isListView);
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10.0),
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
                              ? _goToChild(title, File.folderList, isListView)
                              : print("Click File");
                        },
                      )),
                  GestureDetector(
                    child: Icon(const IconData(0xf8da,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage)),
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

  void _goToChild(title, data, isListViewMode) {}
}
