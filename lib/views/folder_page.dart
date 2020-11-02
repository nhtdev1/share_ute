import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/blocs/folder_bloc.dart';
import 'package:share_ute/search_screen/view/search_page.dart';
import 'package:share_ute/widgets/folder_bottom_actions_sheet.dart';
import 'package:share_ute/widgets/folder_create_bottom_sheet.dart';
import 'package:share_ute/widgets/folder_sortby_bottom_sheet.dart';
import 'package:share_ute/models/file.dart';

class MyFolderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<File> data = new List<File>();
    File file = new File(
        id: '100',
        isFolder: true,
        fileName: "Hệ CLC",
        fileType: "folder",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        id: '200',
        isFolder: true,
        fileName: "Hệ Đại Trà",
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

  /// Nếu là folder con (isChild = true)
  final String folderTitle;

  final List<File> data;
  final bool isListView;

  const FolderPage(
      {Key key,
      this.isChild = false,
      this.folderTitle,
      this.data,
      this.isListView = true})
      : super(key: key);

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  FolderBloc _bloc = new FolderBloc();

  bool isListView = true;
  Widget viewMode;

  @override
  void initState() {
    super.initState();
    isListView = widget.isListView;
    viewMode = isListView ? _listViewMode() : _gridViewMode();
    _bloc.init(data: widget.data);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.isChild
            ? AppBar(
                backgroundColor: CupertinoColors.white,
                leading: CupertinoButton(
                  child: Icon(
                    const IconData(0xf4fd,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: CupertinoColors.systemGrey,
                  ),
                  onPressed: () {
                    Navigator.pop(context, isListView);
                  },
                ),
                title: Text(
                  widget.folderTitle,
                  style: TextStyle(
                      color: CupertinoColors.systemGrey, fontSize: 16),
                ),
                actions: [
                  CupertinoButton(
                    child: Icon(
                      const IconData(0xf4a5,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage),
                      color: CupertinoColors.systemGrey,
                    ),
                    onPressed: () async {
                      final results =
                          showSearch(context: context, delegate: SearchPage());
                    },
                  ),
                  CupertinoButton(
                    child: Icon(
                      const IconData(0xf8da,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage),
                      color: CupertinoColors.systemGrey,
                    ),
                    onPressed: () {
                      print("more");
                    },
                  )
                ],
              )
            : null,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: FloatingActionButton(
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
                  builder: (builderContext) => FolderCreateBottomSheet(
                        context: context,
                        bloc: _bloc,
                      ));
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: StreamBuilder(
                          stream: _bloc.sortTypeStream,
                          builder: (context, snapshot) => Row(
                            children: [
                              Text(
                                _bloc.curSortType.convertToString,
                                style: TextStyle(fontSize: 14),
                              ),
                              Icon(
                                _bloc.isIncrement
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: Colors.black,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (builderContext) =>
                                  FolderSortByBottomSheet(
                                      context: context,
                                      bloc: _bloc,
                                      curSortSelection: _bloc.curSortType,
                                      isIncrement: _bloc.isIncrement));
                        },
                      ),
                    ],
                  ),
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
                        _changeTypeView();
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
            Expanded(
              child: viewMode,
            )
          ],
        ));
  }

  Widget _listViewMode() {
    return Container(
      child: StreamBuilder(
          stream: _bloc.listDataStream,
          builder: (context, snapshot) => _bloc.getLength > 0
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: _bloc.getLength,
                  itemBuilder: (context, index) {
                    return _mediaListItem(
                        _bloc.getData[index].id,
                        _bloc.getData[index].fileName,
                        _bloc.getData[index].isFolder
                            ? CupertinoColors.systemGrey
                            : CupertinoColors.activeBlue,
                        Colors.transparent,
                        _bloc.getData[index].dateCreated
                            .toString()
                            .split(' ')[0],
                        _bloc.getData[index].isFolder
                            ? const IconData(0xf435,
                                fontFamily: CupertinoIcons.iconFont,
                                fontPackage: CupertinoIcons.iconFontPackage)
                            : Icons.insert_drive_file,
                        isFolder: _bloc.getData[index].isFolder,
                        isChoose: _bloc.indexItemChose
                            .contains(_bloc.getData[index].id));
                  })
              : Center(
                  child: Text("NO ITEMS"),
                )),
    );
  }

  Widget _gridViewMode() {
    return Container(
      child: StreamBuilder(
        stream: _bloc.listDataStream,
        builder: (context, snapshot) => _bloc.getLength > 0
            ? GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _bloc.getLength,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return _mediaGridItem(
                      _bloc.getData[index].id,
                      _bloc.getData[index].fileName,
                      _bloc.getData[index].isFolder
                          ? CupertinoColors.systemGrey
                          : CupertinoColors.activeBlue,
                      Colors.transparent,
                      _bloc.getData[index].dateCreated.toString(),
                      _bloc.getData[index].isFolder
                          ? const IconData(0xf435,
                              fontFamily: CupertinoIcons.iconFont,
                              fontPackage: CupertinoIcons.iconFontPackage)
                          : Icons.insert_drive_file,
                      isFolder: _bloc.getData[index].isFolder,
                      isChoose: _bloc.indexItemChose
                          .contains(_bloc.getData[index].id));
                })
            : Center(
                child: Text("NO ITEMS"),
              ),
      ),
    );
  }

  Widget _mediaListItem(String itemId, String title, Color iconColor,
      Color accent, String meta, IconData mediaIcon,
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
                      _goToChild(
                          title, _bloc.getChildOf(folderId: '0'), isListView);
                  },
                  onLongPress: () {
                    _bloc.selected(itemId);
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
                  ? _goToChild(
                      title, _bloc.getChildOf(folderId: '1'), isListView)
                  : print("Click File");
            },
            onLongPress: () {
              _bloc.selected(itemId);
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
                              bloc: _bloc,
                              iconData: mediaIcon,
                              iconColor: iconColor,
                              itemId: itemId,
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

  Widget _mediaGridItem(String itemId, String title, Color iconColor,
      Color accent, String meta, IconData mediaIcon,
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
                        _goToChild(
                            title, _bloc.getChildOf(folderId: '1'), isListView);
                    },
                    onLongPress: () {
                      _bloc.selected(itemId);
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
                              ? _goToChild(title,
                                  _bloc.getChildOf(folderId: '1'), isListView)
                              : print("Click File");
                        },
                        onLongPress: () {
                          _bloc.selected(itemId);
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
                                bloc: _bloc,
                                iconData: mediaIcon,
                                iconColor: iconColor,
                                itemId: itemId,
                              ));
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }

  /// Gọi lại chính trang này nhưng với nội dung khác
  void _goToChild(title, data, isListViewMode) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FolderPage(
                folderTitle: title,
                data: data,
                isListView: isListViewMode,
                isChild: true,
              )),
    );
    if (result != isListView) {
      setState(() {
        _changeTypeView();
      });
    }
  }

  /// Thay đổi giữa list view và grid view
  void _changeTypeView() {
    isListView = !isListView;
    var data = _bloc.getData;
    var isIncre = _bloc.isIncrement;
    var typeSort = _bloc.curSortType;
    var listSelected = _bloc.indexItemChose;
    _bloc.dispose();
    _bloc = new FolderBloc();
    _bloc.init(data: data, isIncrement: isIncre, type: typeSort);
    _bloc.indexItemChose = listSelected;
    viewMode = isListView ? _listViewMode() : _gridViewMode();
  }
}
