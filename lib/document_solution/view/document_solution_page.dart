import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/solutions/solutions.dart';
import 'package:solution_repository/solution_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DocumentSolutionPage extends StatefulWidget {
  const DocumentSolutionPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (context) => const DocumentSolutionPage());
  }

  @override
  _DocumentSolutionPageState createState() => _DocumentSolutionPageState();
}

class _DocumentSolutionPageState extends State<DocumentSolutionPage> {
  final _scrollController = ScrollController();
  final _refreshController = RefreshController(initialRefresh: false);
  SolutionBloc _solutionBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _solutionBloc = context.read<SolutionBloc>();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 200));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolutionBloc, SolutionState>(
      builder: (context, state) {
        switch (state.status) {
          case SolutionStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case SolutionStatus.success:
            if (state.solutions.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
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
    if (_isBottom) _solutionBloc.add(SolutionFetched());
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
    return ListTile(
      leading: Text(
        '${solution.uid}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(solution.title),
      isThreeLine: true,
      subtitle: Text(solution.dateCreated),
      dense: true,
    );
  }
}
