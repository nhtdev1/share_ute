import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_ute/document_solution/document_solution.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/react_solution/react_solution.dart';
import 'package:solution_repository/solution_repository.dart';

class DocumentSolutionForm extends StatefulWidget {
  @override
  _DocumentSolutionFormState createState() => _DocumentSolutionFormState();
}

class _DocumentSolutionFormState extends State<DocumentSolutionForm> {
  final _scrollController = ScrollController();
  final _refreshController = RefreshController(initialRefresh: false);
  DocumentSolutionBloc _solutionBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _solutionBloc = context.read<DocumentSolutionBloc>();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 300));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentSolutionBloc, DocumentSolutionState>(
      builder: (context, state) {
        switch (state.status) {
          case DocumentSolutionStatus.failure:
            return const Center(child: Text('Thất bại trong việc tải đáp án'));
          case DocumentSolutionStatus.success:
            if (state.solutions.isEmpty) {
              return const Center(child: Text('Tài liệu này chưa có đáp án'));
            }
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  //_check();
                  return index >= state.solutions.length
                      ? BottomLoader()
                      : SolutionWidget(solution: state.solutions[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.solutions.length
                    : state.solutions.length + 1,
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
      _solutionBloc.add(DocumentSolutionFetched());
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

class SolutionWidget extends StatelessWidget {
  const SolutionWidget({Key key, @required this.solution}) : super(key: key);

  final Solution solution;
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
                  solution.photoURL,
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
                  solution.title.isEmpty
                      ? solution.solutionFile.fileName
                      : solution.title,
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
                      int.parse(solution.dateCreated),
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
            ReactSolutionPage(
              solution: solution,
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

// listener: (context, state) {
//   if (!state.hasReachedMax) {
//     final marg = MediaQuery.of(context).size.width / 3;
//     Scaffold.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(
//         SnackBar(
//           duration: Duration(days: 10),
//           margin: EdgeInsets.only(left: marg, right: marg, bottom: 20),
//           backgroundColor: Colors.blue,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20))),
//           content: Text(
//             '3 bình luận mới',
//             style: TextStyle(
//               fontSize: 14,
//             ),
//           ),
//         ),
//       );
//   }
// },
