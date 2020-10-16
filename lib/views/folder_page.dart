import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'storage_page.dart';
import 'package:share_ute/utils/responsive.dart';
import 'package:share_ute/models/file.dart';

class FolderPage extends StatefulWidget {
  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  var isListView = true;
  List<File> myFiles = new List<File>();

  List<File> getData() {
    List<File> data = new List<File>();
    File file = new File(
        fileName: "De thi CNTT HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi CNTT HK2 2019",
        fileType: "word",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi CNTT HK1 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi Co Khi Che Tao May HK2 2019",
        fileType: "excel",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi CN May HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi Kinh Te HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi Xay Dung HK2 2019",
        fileType: "word",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi CNTT HK2 2019",
        fileType: "word",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi Dien-Dien Tu HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi CNTT HK2 2019",
        fileType: "pdf",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi CNTT HK2 2019",
        fileType: "word",
        dateCreated: DateTime.now());
    data.add(file);

    file = new File(
        fileName: "De thi CNTT HK2 2019",
        fileType: "word",
        dateCreated: DateTime.now());
    data.add(file);

    return data;
  }

  @override
  void initState() {
    super.initState();
    myFiles = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0E2C3E), //Color(0xFF2c2c3c),
        leading: Padding(
          padding: EdgeInsets.only(
            top: 1.8 * Responsive.imageSizeMultiplier,
            left: 6 * Responsive.imageSizeMultiplier,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey[500],
            ),
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: 1.8 * Responsive.imageSizeMultiplier,
          //     right: 6 * Responsive.imageSizeMultiplier,
          //   ),
          //   child: Opacity(
          //     opacity: 0.5,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.indigo[100],
          //         shape: BoxShape.circle,
          //         border: Border.all(
          //           color: Colors.indigo,
          //           width: 0.25 * Responsive.imageSizeMultiplier,
          //         ),
          //       ),
          //       child: Padding(
          //         padding: EdgeInsets.all(2.6 * Responsive.imageSizeMultiplier),
          //         child: Icon(
          //           Icons.person,
          //           color: Colors.indigo,
          //           size: 4.5 * Responsive.imageSizeMultiplier,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 0.33 * MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Color(0xff0E2C3E), //Color(0xFF2c2c3c),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                )),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    right: 6 * Responsive.imageSizeMultiplier,
                    top: 6 * Responsive.imageSizeMultiplier,
                    left: 6 * Responsive.imageSizeMultiplier,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 3 * Responsive.widthMultiplier,
                        ),
                        child: Image.asset(
                          "assets/images/HCMUTE.png",
                          height: 3.4 * Responsive.textMultiplier,
                        ),
                      ),
                      Text(
                        "Private",
                        style: TextStyle(
                          fontSize: 3.4 * Responsive.textMultiplier,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.more_horiz,
                        size: 6 * Responsive.imageSizeMultiplier,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 6 * Responsive.imageSizeMultiplier,
                    left: 6 * Responsive.imageSizeMultiplier,
                    top: 10 * Responsive.imageSizeMultiplier,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "32.9",
                        style: TextStyle(
                          fontSize: 7.6 * Responsive.textMultiplier,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 0.57 * MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: 1 * Responsive.heightMultiplier,
                                left: 2 * Responsive.widthMultiplier,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Gb",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Spacer(),
                                  Text(
                                    "223.1 Gb",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0.5 * Responsive.heightMultiplier,
                                left: 2 * Responsive.widthMultiplier,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Used",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Free",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 6 * Responsive.imageSizeMultiplier,
                    left: 6 * Responsive.imageSizeMultiplier,
                    top: 10 * Responsive.imageSizeMultiplier,
                  ),
                  child: Center(
                    child: LinearPercentIndicator(
                      width: 0.87 * MediaQuery.of(context).size.width,
                      lineHeight: 8.0,
                      percent: 0.2,
                      progressColor: Colors.greenAccent,
                      backgroundColor: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 4 * Responsive.heightMultiplier,
              bottom: 2 * Responsive.heightMultiplier,
              left: 6 * Responsive.imageSizeMultiplier,
              right: 6 * Responsive.imageSizeMultiplier,
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 6 * Responsive.heightMultiplier,
                ),
                Text(
                  "Media Files",
                  style: TextStyle(
                    fontSize: 3.4 * Responsive.textMultiplier,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  child: Icon(
                    Icons.search,
                    size: 6 * Responsive.imageSizeMultiplier,
                    color: Colors.grey[500],
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Icon(
                    isListView ? Icons.format_list_bulleted : Icons.grid_on,
                    size: 6 * Responsive.imageSizeMultiplier,
                    color: Colors.grey[500],
                  ),
                  onTap: () {
                    setState(() {
                      isListView = !isListView;
                    });
                  },
                )
              ],
            ),
          ),
          isListView
              ? Container(
                  height: 57 * Responsive.heightMultiplier,
                  child: ListView.builder(
                      itemCount: myFiles.length + 1,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return index < myFiles.length
                            ? _mediaListItem(
                                myFiles[index].fileName,
                                myFiles[index].fileType == 'pdf'
                                    ? Colors.red[500]
                                    : Colors.blue[500],
                                myFiles[index].fileType == 'pdf'
                                    ? Colors.red[100]
                                    : Colors.blue[100],
                                myFiles[index].dateCreated.toString(),
                                myFiles[index].fileType == 'pdf'
                                    ? Icons.insert_drive_file
                                    : Icons.note)
                            : SizedBox(
                                width: 15,
                              );
                      }),
                )
              : Container(
                  height: 50 * Responsive.heightMultiplier,
                  child: GridView.builder(
                      itemCount: myFiles.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return _mediaGridItem(
                            myFiles[index].fileName,
                            myFiles[index].fileType == 'pdf'
                                ? Colors.red[500]
                                : Colors.blue[500],
                            myFiles[index].fileType == 'pdf'
                                ? Colors.red[100]
                                : Colors.blue[100],
                            myFiles[index].dateCreated.toString(),
                            myFiles[index].fileType == 'pdf'
                                ? Icons.insert_drive_file
                                : Icons.note);
                      }),
                )
        ],
      ),
    );
  }

  Widget _mediaListItem(String title, Color iconColor, Color accent,
      String meta, IconData mediaIcon) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 2 * Responsive.heightMultiplier,
        left: 6 * Responsive.widthMultiplier,
      ),
      child: Row(
        children: <Widget>[
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(6.8),
              ),
              child: Padding(
                padding: EdgeInsets.all(3 * Responsive.imageSizeMultiplier),
                child: Icon(
                  mediaIcon,
                  size: 6 * Responsive.imageSizeMultiplier,
                  color: iconColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0 * Responsive.widthMultiplier),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 2.3 * Responsive.textMultiplier,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 0.5 * Responsive.heightMultiplier,
                ),
                Text(
                  meta,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 1.8 * Responsive.textMultiplier,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mediaGridItem(String title, Color iconColor, Color accent,
      String meta, IconData mediaIcon) {
    return Padding(
        padding: EdgeInsets.only(
          bottom: 2 * Responsive.heightMultiplier,
          left: 2 * Responsive.widthMultiplier,
          right: 2 * Responsive.widthMultiplier,
        ),
        child: Container(
          width: 25 * Responsive.widthMultiplier,
          height: 30 * Responsive.widthMultiplier,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 20 * Responsive.widthMultiplier,
                height: 20 * Responsive.widthMultiplier,
                decoration: BoxDecoration(
                    color: accent, borderRadius: BorderRadius.circular(15)),
                child: Icon(
                  mediaIcon,
                  size: 15 * Responsive.imageSizeMultiplier,
                  color: iconColor,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 2 * Responsive.textMultiplier,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        )
        // child: Row(
        //   children: <Widget>[
        //     Center(
        //       child: Container(
        //         decoration: BoxDecoration(
        //           color: accent,
        //           borderRadius: BorderRadius.circular(6.8),
        //         ),
        //         child: Padding(
        //           padding: EdgeInsets.all(3 * Responsive.imageSizeMultiplier),
        //           child: Icon(
        //             mediaIcon,
        //             size: 6 * Responsive.imageSizeMultiplier,
        //             color: icon,
        //           ),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.only(left: 5.0 * Responsive.widthMultiplier),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: <Widget>[
        //           Text(
        //             title,
        //             style: TextStyle(
        //               fontSize: 2.3 * Responsive.textMultiplier,
        //               fontWeight: FontWeight.w600,
        //               color: Colors.grey[600],
        //             ),
        //           ),
        //           SizedBox(
        //             height: 0.5 * Responsive.heightMultiplier,
        //           ),
        //           Text(
        //             meta,
        //             style: TextStyle(
        //               fontWeight: FontWeight.w400,
        //               fontSize: 1.8 * Responsive.textMultiplier,
        //               color: Colors.grey[500],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
