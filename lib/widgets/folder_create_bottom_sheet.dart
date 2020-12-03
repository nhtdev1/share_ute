import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_ute/blocs/folder_bloc.dart';
import 'package:share_ute/widgets/folder_components/popup_input.dart';
import 'package:image_picker/image_picker.dart';

import 'folder_components/action_type.dart';

class FolderCreateBottomSheet extends StatefulWidget {
  // final IconData iconData;
  // final Color iconColor;
  // final String title;
  //
  // const FolderCreateBottomSheet(
  //     {Key key, this.iconData, this.iconColor, this.title})
  //     : super(key: key);
  final context;
  final FolderBloc bloc;
  const FolderCreateBottomSheet({Key key, this.context, this.bloc});
  @override
  State<StatefulWidget> createState() {
    return _FolderCreateBottomSheet();
  }
}

class _FolderCreateBottomSheet extends State<FolderCreateBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Wrap(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 30),
                child: Text(
                  "Create new",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: Icon(Icons.folder_open),
                        ),
                        Text(
                          "Folder",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (_) => PopupInput(
                                title: "New Folder",
                                hintText: "Untitled folder",
                                text: "Untitled folder",
                                action: ACTION_TYPE.CANCEL_CREATE,
                                callback: widget.bloc.createFolder,
                              ));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Icon(
                                Icons.insert_drive_file,
                                color: Colors.blue[900],
                              ),
                            ),
                            Text(
                              "Google Docs",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: Icon(Icons.file_upload),
                        ),
                        Text(
                          "Upload",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      //filePicker();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Icon(
                                Icons.insert_drive_file,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              "Google Sheets",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: Icon(Icons.camera_alt),
                        ),
                        Text(
                          "Scan",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    onTap: () {
                      getImage();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              child: Icon(
                                Icons.insert_drive_file,
                                color: Colors.yellow,
                              ),
                            ),
                            Text(
                              "Google Slides",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Future<List<File>> filePicker() async {
  //   Directory rootPath = Directory.systemTemp;
  //   List<File> files = List<File>();
  //   FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //
  //   if(result != null) {
  //     List<File> files = result.paths.map((path) => File(path)).toList();
  //   } else {
  //     // User canceled the picker
  //   }
  //
  //   return files;
  // }

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
