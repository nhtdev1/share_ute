import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:share_ute/document_info/document_info.dart';

class DocumentInfoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentInfoBloc, DocumentInfoState>(
      builder: (context, state) {
        return Container(
          color: CupertinoColors.white,
          child: Stack(
            children: [
              // Chứa ảnh tài liệu
              GestureDetector(
                child: AspectRatio(
                  aspectRatio: 6 / 5,
                  child: Image.asset('assets/images/webInterFace.png'),
                ),
                onTap: () async {
                  PdftronFlutter.initialize('');
                  await PdftronFlutter.version;
                  await PdftronFlutter.openDocument(
                      state.post.originalFile.path);
                },
              ),

              // Chứa tiêu đề, ngày tạo, tags của tài liệu
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.systemGrey3,
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 50, left: 10, right: 10),
                            child: Text(
                              state.post.postTitle.isNotEmpty
                                  ? state.post.postTitle
                                  : 'Tiêu đề của tài liệu',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: CupertinoColors.darkBackgroundGray),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 10, right: 10),
                            child: Text(
                              state.post.dateCreated,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 0.27,
                                color: CupertinoColors.darkBackgroundGray
                                    .withOpacity(0.8),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                          ),

                          // Tags
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              bottom: 5,
                            ),
                            child: Icon(
                              const IconData(
                                0xf48c,
                                fontFamily: CupertinoIcons.iconFont,
                                fontPackage: CupertinoIcons.iconFontPackage,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: _buildHobbies(state, context),
                          ),
                          Divider(),
                          // year
                          if (state.post.postYear.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      'Tài liệu của năm',
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        state.post.postYear,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          letterSpacing: 1.0,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // faculty
                          if (state.post.semester.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      'Học kỳ',
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        state.post.semester,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          letterSpacing: 1.0,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // credit
                          if (state.post.credit.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      'Số tín chỉ',
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        state.post.credit,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          letterSpacing: 1.0,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // lecturer
                          if (state.post.lecturer.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      'Giảng viên',
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        state.post.lecturer,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 15,
                                          letterSpacing: 1.0,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //Like Icon
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35.0,
                right: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CupertinoButton(
                          child: Icon(
                            const IconData(
                              0xf6b7,
                              fontFamily: CupertinoIcons.iconFont,
                              fontPackage: CupertinoIcons.iconFontPackage,
                            ),
                          ),
                          onPressed: () {
                            print('Like');
                          },
                        ),
                      ),
                      color: CupertinoColors.extraLightBackgroundGray,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(state.post.like.toString())
                  ],
                ),
              ),

              //Dislike Icon
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35.0,
                right: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CupertinoButton(
                          child: Icon(
                            const IconData(
                              0xf6b5,
                              fontFamily: CupertinoIcons.iconFont,
                              fontPackage: CupertinoIcons.iconFontPackage,
                            ),
                          ),
                          onPressed: () {
                            print('Dislike');
                          },
                        ),
                      ),
                      color: CupertinoColors.extraLightBackgroundGray,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(state.post.dislike.toString())
                  ],
                ),
              ),

              //Avatar Icon
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35.0,
                left: 15,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CupertinoColors.extraLightBackgroundGray,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                    child: Image.network(
                        'https://randomuser.me/api/portraits/men/31.jpg'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildHobbies(DocumentInfoState state, BuildContext context) {
    List<Widget> chips = List();
    state.post.postTags.forEach((element) {
      chips.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: Chip(
            deleteIconColor: Colors.white,
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.lightBlueAccent,
            label: Text(
              element,
            ),
          ),
        ),
      );
    });

    return Wrap(
      children: chips,
    );
  }
}
