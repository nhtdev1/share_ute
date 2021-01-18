import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_ute/document_solution/document_solution.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/react_solution/react_solution.dart';
import 'package:share_ute/system_notification/system_notification.dart';
import 'package:share_ute/user_rating/user_rating.dart';
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
                          child: Image.network(solution.photoURL),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          UserRatingPage.route(
                              solution.username, solution.photoURL),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      child: Text(
                        solution.username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          UserRatingPage.route(
                              solution.username, solution.photoURL),
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

          if (solution.title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                child: Text(solution.title),
              ),
            ),
          //File
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(solution.solutionFile.fileName),
                ),
                IconButton(
                  icon: Icon(
                    Icons.open_in_new_outlined,
                    size: 20.0,
                  ),
                  onPressed: () {
                    _openFile(solution.solutionFile.path);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 3, bottom: 3),
            child: Row(
              children: [
                _DateCreated(solution.dateCreated),
                const SizedBox(
                  width: 10,
                ),
                ReactSolutionPage(
                  solution: solution,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _openFile(String path) async {
    PdftronFlutter.initialize('');
    await PdftronFlutter.version;
    await PdftronFlutter.openDocument(path);
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
