import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/report_post/report_post.dart';

class ReportPostForm extends StatelessWidget {
  const ReportPostForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          _SubmitButton(),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: _Problem(),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportPostCubit, ReportPostState>(
      builder: (context, state) {
        if (state.detail.isNotEmpty)
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              state.reportPostProgress ==
                      ReportPostProgress.submissionInProgress
                  ? CircularProgressIndicator(
                      strokeWidth: 1,
                    )
                  : GestureDetector(
                      child: Text(
                        'Xong',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        context.read<ReportPostCubit>().submit();
                        context.read<NotificationCubit>().newReportCreated();
                        Navigator.pop(context);
                      },
                    ),
            ],
          );

        return Container();
      },
    );
  }
}

class _Problem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportPostCubit, ReportPostState>(
      builder: (context, state) {
        return Container(child: _buidProblems(context, state));
      },
    );
  }

  Widget _buidProblems(BuildContext context, ReportPostState state) {
    return ExpansionPanelList(
      dividerColor: Colors.grey.withOpacity(0.2),
      expansionCallback: (index, isExpanded) {
        final name = Problems.terms[index].name == state.name
            ? ''
            : Problems.terms[index].name;
        context.read<ReportPostCubit>().problemChanged(name);
      },
      children: Problems.terms
          .map<ExpansionPanel>(
            (item) => ExpansionPanel(
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  title: Text(
                    item.name,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                );
              },
              body: _buildDetails(context, state, item),
              isExpanded: item.name == state.name ? true : false,
            ),
          )
          .toList(),
    );
  }

  _buildDetails(
    BuildContext context,
    ReportPostState state,
    ProblemItem problem,
  ) {
    final results = problem.details
        .map((e) => GestureDetector(
              child: Card(
                color: e == state.detail ? Colors.lightBlueAccent : null,
                margin: const EdgeInsets.all(15.0),
                elevation: 3.0,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 16,
                      color: e == state.detail ? Colors.white : null,
                    ),
                  ),
                ),
              ),
              onTap: () {
                final detail = state.detail == e ? '' : e;
                context.read<ReportPostCubit>().detailChanged(detail);
              },
            ))
        .toList();
    return ListView(
      shrinkWrap: true,
      children: results,
    );
  }
}
