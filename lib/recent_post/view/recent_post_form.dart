import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/recent_post/recent_post.dart';
import 'package:share_ute/system_notification/system_notification.dart';
import 'package:share_ute/user_rating/user_rating.dart';

class RecentPostForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentPostCubit, RecentPostState>(
      builder: (context, state) {
        return state.posts.isEmpty
            ? Container(
                child: Center(
                  child: Text('Chưa có bài viết nào gần đây'),
                ),
              )
            : Column(
                children: [
                  _PostsToolbar(),
                  _PostsView(),
                ],
              );
      },
    );
  }
}

class _PostsToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentPostCubit, RecentPostState>(
      builder: (context, state) {
        return Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            IconButton(
              icon: Icon(
                Icons.sort,
                color: Colors.grey,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => RecentFilterBottomSheet(
                    posts: state.posts,
                    sortCallBack: (type) {
                      context.read<RecentPostCubit>().sortBy(type);
                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
            Spacer(),
            IconButton(
              icon: state.viewMode == PostViewMode.isList
                  ? Icon(
                      Icons.view_module,
                      color: Colors.grey,
                    )
                  : Icon(
                      Icons.view_list,
                      color: Colors.grey,
                    ),
              onPressed: () {
                context.read<RecentPostCubit>().switchViewMode();
              },
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        );
      },
    );
  }
}

class _PostsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentPostCubit, RecentPostState>(
      builder: (context, state) {
        if (state.viewMode == PostViewMode.isList) {
          return _buildListViewPosts(state);
        } else {
          return _buildGridViewPosts(state);
        }
      },
    );
  }

  Widget _buildListViewPosts(RecentPostState state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
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
                      child: Image.network(state.posts[index].photoURL),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      UserRatingPage.route(state.posts[index].username,
                          state.posts[index].photoURL),
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                state.posts[index].originalFile.fileExtension.contains('pdf')
                    ? Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset(
                          'assets/images/pdf_icon.png',
                          fit: BoxFit.contain,
                        ),
                      )
                    : state.posts[index].originalFile.fileExtension
                            .contains('doc')
                        ? Container(
                            height: 30,
                            width: 30,
                            child: Image.asset(
                              'assets/images/doc_icon.png',
                              fit: BoxFit.contain,
                            ),
                          )
                        : state.posts[index].originalFile.fileExtension
                                .contains('xls')
                            ? Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/xls_icon.png',
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/ppt_icon.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
              ],
            ),
            title: GestureDetector(
              child: Text('${state.posts[index].originalFile.fileName}'),
              onTap: () {
                context
                    .read<NotificationCubit>()
                    .currentPostChanged(post: state.posts[index]);
              },
            ),
            subtitle: _DateCreated(state.posts[index].dateCreated),
            trailing: Container(
              width: 30,
              height: 30,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.expand_more_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) =>
                          RecentPostBottomSheet(post: state.posts[index]),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridViewPosts(RecentPostState state) {
    return Expanded(
      child: GridView.builder(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          itemCount: state.posts.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Icon(
                      Icons.folder,
                      size: MediaQuery.of(context).size.width / 3,
                      color: Colors.lightBlueAccent,
                    ),
                    Positioned(
                      bottom: 30,
                      right: 15,
                      child: state.posts[index].originalFile.fileExtension
                              .contains('pdf')
                          ? Container(
                              padding: const EdgeInsets.all(6.0),
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                'assets/images/pdf_icon.png',
                                fit: BoxFit.contain,
                              ),
                            )
                          : state.posts[index].originalFile.fileExtension
                                  .contains('doc')
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    'assets/images/doc_icon.png',
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : state.posts[index].originalFile.fileExtension
                                      .contains('xls')
                                  ? Container(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        'assets/images/xls_icon.png',
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : Container(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        'assets/images/ppt_icon.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                    )
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(60.0)),
                            child: Image.network(state.posts[index].photoURL),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            UserRatingPage.route(state.posts[index].username,
                                state.posts[index].photoURL),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                              '${state.posts[index].originalFile.fileName}'),
                          onTap: () {
                            context
                                .read<NotificationCubit>()
                                .currentPostChanged(post: state.posts[index]);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
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
    if (hours < 24) return '$hours giờ';
    if (days < 30) return '$days ngày';
    if (days < 365) return '${days / 30} tháng';
    return '${days / 365} năm';
  }
}
