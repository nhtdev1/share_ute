import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_repository/post_repository.dart';

class DocumentDetails extends StatelessWidget {
  DocumentDetails(this.post);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.width / 1.2) - 24.0 + 50,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: CupertinoColors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    post.postTitle.isNotEmpty
                        ? post.postTitle
                        : 'Tiêu đề của tài liệu',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 0.27,
                      color: CupertinoColors.darkBackgroundGray,
                    ),
                    maxLines: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                  child: Text(
                    DateFormat('yyyy-MM-dd – kk:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        int.parse(post.dateCreated),
                      ),
                    ),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.27,
                      color:
                          CupertinoColors.darkBackgroundGray.withOpacity(0.8),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: _buildHobbies(post),
                ),
                Divider(),
                // year
                if (post.postYear.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            'Năm',
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              post.postYear,
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
                if (post.semester.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            'Học kỳ',
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              post.semester,
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
                if (post.credit.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            'Số tín chỉ',
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              post.credit,
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
                if (post.lecturer.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Text(
                            'Giảng viên',
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              post.lecturer,
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
    );
  }

  _buildHobbies(Post post) {
    List<Widget> chips = [];
    post.postTags.forEach((element) {
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
