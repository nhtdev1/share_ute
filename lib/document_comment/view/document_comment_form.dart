import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/document_comment/document_comment.dart';
import 'package:comment_repository/comment_repository.dart';
import 'package:share_ute/react_comment/react_comment.dart';
import 'package:share_ute/system_notification/system_notification.dart';
import 'package:share_ute/user_rating/user_rating.dart';

class DocumentCommentForm extends StatefulWidget {
  @override
  _DocumentCommentFormState createState() => _DocumentCommentFormState();
}

class _DocumentCommentFormState extends State<DocumentCommentForm> {
  final _scrollController = ScrollController();
  final _refreshController = RefreshController(initialRefresh: false);
  DocumentCommentBloc _commentBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _commentBloc = context.read<DocumentCommentBloc>();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 300));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentCommentBloc, DocumentCommentState>(
      builder: (context, state) {
        switch (state.status) {
          case DocumentCommentStatus.failure:
            return const Center(
                child: Text('Thất bại trong việc tải bình luận'));
          case DocumentCommentStatus.success:
            if (state.comments.isEmpty) {
              return const Center(child: Text('Chưa có bình luận nào'));
            }
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.comments.length
                      ? BottomLoader()
                      : CommentWidget(comment: state.comments[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.comments.length
                    : state.comments.length + 1,
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
      _commentBloc.add(DocumentCommentFetched());
    }
  }

  bool get _isBottom {
    // Check whether has position object is attached to Scrollcontroller or not
    if (!_scrollController.hasClients) return false;
    // The maximum in-range value for [pixels] (ứng với chiều dài pixel
    // tử hiện có trong listview)
    final maxScroll = _scrollController.position.maxScrollExtent;
    print("Max scroll $maxScroll");
    // The current scroll offset of the scrollable widget (Phần bị ẩn đi khi cuộn)
    final currentScroll = _scrollController.offset;
    print("Current scroll $currentScroll");
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

class CommentWidget extends StatelessWidget {
  const CommentWidget({Key key, @required this.comment}) : super(key: key);

  final Comment comment;
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
                          child: Image.network(comment.photoURL),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          UserRatingPage.route(
                              comment.username, comment.photoURL),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      child: Text(
                        comment.username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          UserRatingPage.route(
                              comment.username, comment.photoURL),
                        );
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.expand_more_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          if (comment.title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                child: Text(comment.title),
              ),
            ),
          if (comment.gifURL.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 3.0,
              ),
              child: Container(
                child: Image.network(comment.gifURL),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 5, bottom: 3),
            child: Row(
              children: [
                _DateCreated(comment.dateCreated),
                const SizedBox(
                  width: 10,
                ),
                ReactCommentPage(
                  comment: comment,
                ),
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
