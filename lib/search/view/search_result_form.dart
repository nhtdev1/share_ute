import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/post_notification/cubit/post_notification_cubit.dart';
import 'package:share_ute/report_post/report_post.dart';
import 'package:share_ute/system_notification/system_notification.dart';
import 'package:share_ute/user_rating/user_rating.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResultForm extends StatelessWidget {
  SearchResultForm({this.posts});
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return PostWidget(post: posts[index]);
      },
      itemCount: posts.length,
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({Key key, @required this.post}) : super(key: key);

  final Post post;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avataar, Name
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 10.0, top: 2.0, bottom: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(60.0)),
                          child: Image.network(post.photoURL),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          UserRatingPage.route(post.username, post.photoURL),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      child: Text(
                        post.username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          UserRatingPage.route(post.username, post.photoURL),
                        );
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.expand_more_outlined),
                  onPressed: () {
                    final recent = context.read<PostNotificationCubit>();
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        title: Text(
                          post.postTitle,
                          style: TextStyle(fontSize: 16),
                        ),
                        actions: [
                          CupertinoActionSheetAction(
                            child: Row(
                              children: [
                                Icon(const IconData(0xf8c4,
                                    fontFamily: CupertinoIcons.iconFont,
                                    fontPackage:
                                        CupertinoIcons.iconFontPackage)),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Tải xuống',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            onPressed: () {},
                          ),
                          CupertinoActionSheetAction(
                            child: Row(
                              children: [
                                Icon(const IconData(0xf4be,
                                    fontFamily: CupertinoIcons.iconFont,
                                    fontPackage:
                                        CupertinoIcons.iconFontPackage)),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Xem sau',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            onPressed: () {
                              recent.addRecentPost(post);
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Row(
                              children: [
                                Icon(const IconData(0xf660,
                                    fontFamily: CupertinoIcons.iconFont,
                                    fontPackage:
                                        CupertinoIcons.iconFontPackage)),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Báo cáo bài viết',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                ReportPostPage.route(post),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          if (post.postTitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(post.postTitle),
              ),
            ),

          // Fileholder
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: AspectRatio(
                    aspectRatio: 2.5,
                    child: SvgPicture.asset(
                      post.originalFile.fileExtension.contains('doc')
                          ? 'assets/images/thumbnail_word.svg'
                          : post.originalFile.fileExtension.contains('xls')
                              ? 'assets/images/thumbnail_xls.svg'
                              : post.originalFile.fileExtension.contains('ppt')
                                  ? 'assets/images/thumbnail_ppt.svg'
                                  : 'assets/images/thumbnail_pdf.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              onTap: () {
                context.read<PostNotificationCubit>().addRecentPost(post);
                context
                    .read<NotificationCubit>()
                    .currentPostChanged(post: post);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 5, bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _DateCreated(post.dateCreated),
                Row(
                  children: [
                    Icon(
                      Icons.download_outlined,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '0',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DateCreated extends StatelessWidget {
  _DateCreated(this.dateCreated);
  final String dateCreated;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemNotificationCubit, SystemNotificationState>(
      buildWhen: (previous, current) => previous.dateTime != current.dateTime,
      builder: (context, state) {
        return Text(
          _builDateCreated(state.dateTime),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 13,
            letterSpacing: 0.27,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  _builDateCreated(DateTime now) {
    if (now == null) now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(
      int.parse(dateCreated),
    );

    final seconds = now.difference(date).inSeconds;
    final minutes = now.difference(date).inMinutes;
    final hours = now.difference(date).inHours;
    final days = now.difference(date).inDays;
    if (seconds < 60) return 'Vừa xong';
    if (minutes < 60) return '$minutes phút';
    if (hours < 60) return '$hours giờ';
    if (days < 30) return '$days ngày';
    if (days < 365) return '${days / 30} tháng';
    return '${days / 365} năm';
  }
}
