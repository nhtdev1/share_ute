import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:post_repository/post_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/post/post.dart';
import 'package:share_ute/post_notification/cubit/post_notification_cubit.dart';
import 'package:share_ute/system_notification/system_notification.dart';
import 'package:share_ute/user_rating/user_rating.dart';

class PostForm extends StatefulWidget {
  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _scrollController = ScrollController();
  final _refreshController = RefreshController(initialRefresh: false);
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = context.read<PostBloc>();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 300));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(
                child: Text('Thất bại trong việc tải bài viết'));
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('Chưa có bài viết nào'));
            }
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.posts.length
                      ? BottomLoader()
                      : PostWidget(post: state.posts[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                controller: _scrollController,
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _postBloc.add(PostFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll > (maxScroll * 0.9);
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
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
                  icon: Icon(
                    Icons.expand_more_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => PostBottomSheet(post: post),
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
                                  : post.originalFile.fileExtension
                                          .contains('pdf')
                                      ? 'assets/images/thumbnail_pdf.svg'
                                      : 'assets/images/thumbnail_mp4.svg',
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
                      color: Colors.grey,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '${Random().nextInt(5)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
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
