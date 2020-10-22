import 'package:flutter/material.dart';

class FolderCreateBottomSheet extends StatefulWidget {
  // final IconData iconData;
  // final Color iconColor;
  // final String title;
  //
  // const FolderCreateBottomSheet(
  //     {Key key, this.iconData, this.iconColor, this.title})
  //     : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FolderCreateBottomSheet();
  }
}

class _FolderCreateBottomSheet extends State<FolderCreateBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                              child: Icon(Icons.insert_drive_file, color: Colors.blue[900],),
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
                              child: Icon(Icons.insert_drive_file, color: Colors.green,),
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
                              child: Icon(Icons.insert_drive_file, color: Colors.yellow,),
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
          // Padding(
          //   padding: EdgeInsets.only(top: 40, bottom: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Container(
          //             padding: EdgeInsets.all(10),
          //             margin: EdgeInsets.only(bottom: 10),
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: Colors.white,
          //               border: Border.all(
          //                 width: 1,
          //                 color: Colors.grey,
          //               ),
          //             ),
          //             child: Icon(Icons.insert_drive_file, color: Colors.blue[900],),
          //           ),
          //           Text(
          //             "Google Docs",
          //             style: TextStyle(
          //               fontSize: 12,
          //               color: Colors.black,
          //             ),
          //             overflow: TextOverflow.ellipsis,
          //             maxLines: 1,
          //           ),
          //         ],
          //       ),
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Container(
          //             padding: EdgeInsets.all(10),
          //             margin: EdgeInsets.only(bottom: 10),
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: Colors.white,
          //               border: Border.all(
          //                 width: 1,
          //                 color: Colors.grey,
          //               ),
          //             ),
          //             child: Icon(Icons.insert_drive_file, color: Colors.green,),
          //           ),
          //           Text(
          //             "Google Sheets",
          //             style: TextStyle(
          //               fontSize: 12,
          //               color: Colors.black,
          //             ),
          //             overflow: TextOverflow.ellipsis,
          //             maxLines: 1,
          //           ),
          //         ],
          //       ),
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Container(
          //             padding: EdgeInsets.all(10),
          //             margin: EdgeInsets.only(bottom: 10),
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: Colors.white,
          //               border: Border.all(
          //                 width: 1,
          //                 color: Colors.grey,
          //               ),
          //             ),
          //             child: Icon(Icons.photo_camera),
          //           ),
          //           Text(
          //             "Scan",
          //             style: TextStyle(
          //               fontSize: 12,
          //               color: Colors.black,
          //             ),
          //             overflow: TextOverflow.ellipsis,
          //             maxLines: 1,
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
