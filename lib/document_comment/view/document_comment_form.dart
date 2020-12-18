import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/document_comment/document_comment.dart';
import 'package:comment_repository/comment_repository.dart';
import 'package:share_ute/react_comment/react_comment.dart';

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
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
      child: Container(
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(4.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(60.0),
                ),
                child: Image.network(
                  comment.photoURL,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.title.isEmpty ? '' : comment.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('yyyy-MM-dd – kk:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(
                      int.parse(comment.dateCreated),
                    ),
                  ),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: CupertinoColors.darkBackgroundGray.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            Spacer(),
            ReactCommentPage(
              comment: comment,
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}
