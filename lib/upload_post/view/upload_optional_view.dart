import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upload_post/upload_post.dart';

class UploadOptionalView extends StatelessWidget {
  const UploadOptionalView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Color(0x802196F3),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          _PickSolutionFile(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          _YearRow(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          _SemesterRow(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          _CreditsRow(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          _LecturersInput(),
        ],
      ),
    );
  }
}

class _PickSolutionFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
        buildWhen: (previous, current) =>
            previous.optional.solutionFile != current.optional.solutionFile,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Icon(
                  Icons.lightbulb_outline,
                  color: Colors.yellow,
                ),
              ),
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      state.optional.solutionFile.isNotEmpty
                          ? state.optional.solutionFile.fileName.value
                          : 'Thêm đáp án gợi ý',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        letterSpacing: 1.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                  onTap: () =>
                      context.read<UploadPostCubit>().pickSolutionFile()),
              Spacer(),
              if (state.optional.solutionFile.isNotEmpty)
                IconButton(
                  icon: Icon(
                    Icons.clear,
                  ),
                  onPressed: () =>
                      context.read<UploadPostCubit>().clearSolutionFile(),
                ),
            ],
          );
        });
  }
}

class _YearRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
        buildWhen: (previous, current) =>
            previous.optional.year != current.optional.year,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Icon(
                  Icons.label_important_outline,
                  color: Colors.grey,
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    state.optional.year.isNotEmpty
                        ? state.optional.year.value
                        : 'Tài liệu này năm nào?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      letterSpacing: 1.0,
                      height: 1.5,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<UploadPostCubit>(),
                        child: const UploadYearView(),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        });
  }
}

class _SemesterRow extends StatelessWidget {
  final List<String> data = const [
    "Học kỳ I",
    "Học kỳ II",
    "Học kỳ III",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
        buildWhen: (previous, current) =>
            previous.optional.semester != current.optional.semester,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Icon(
                  Icons.label_important_outline,
                  color: Colors.grey,
                ),
              ),
              _buildSemester(context, state),
            ],
          );
        });
  }

  _buildSemester(BuildContext context, UploadPostState state) {
    List<Widget> tiles = List();
    data.forEach((element) {
      tiles.add(
        GestureDetector(
          child: Card(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  element,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    letterSpacing: 1.0,
                    height: 1.5,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: state.optional.semester.value == element
                    ? Colors.grey.withOpacity(0.2)
                    : null,
              ),
            ),
          ),
          onTap: () {
            if (state.optional.semester.value != element) {
              context.read<UploadPostCubit>().optionalSemesterChanged(element);
            } else {
              context.read<UploadPostCubit>().optionalSemesterChanged('');
            }
          },
        ),
      );
    });
    return Wrap(
      children: tiles,
    );
  }
}

class _CreditsRow extends StatelessWidget {
  final List<String> data = const [
    "1 chỉ",
    "2 chỉ",
    "3 chỉ",
    "4 chỉ",
    "5 chỉ",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
        buildWhen: (previous, current) =>
            previous.optional.credits != current.optional.credits,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Icon(
                  Icons.label_important_outline,
                  color: Colors.grey,
                ),
              ),
              _buildCredits(context, state),
            ],
          );
        });
  }

  _buildCredits(BuildContext context, UploadPostState state) {
    List<Widget> tiles = List();
    data.forEach((element) {
      tiles.add(
        GestureDetector(
          child: Card(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  element,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    letterSpacing: 1.0,
                    height: 1.5,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: state.optional.credits.value == element
                    ? Colors.grey.withOpacity(0.2)
                    : null,
              ),
            ),
          ),
          onTap: () {
            if (state.optional.credits.value != element) {
              context.read<UploadPostCubit>().optionalCreditsChanged(element);
            } else {
              context.read<UploadPostCubit>().optionalCreditsChanged('');
            }
          },
        ),
      );
    });
    return Wrap(
      children: tiles,
    );
  }
}

class _LecturersInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
      buildWhen: (previous, current) =>
          previous.optional.lecturers != current.optional.lecturers,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1 / 8,
              child: Icon(
                Icons.label_important_outline,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: TextField(
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  letterSpacing: 1.0,
                  height: 1.5,
                ),
                onChanged: (value) => context
                    .read<UploadPostCubit>()
                    .optionalLecturersChanged(value),
                key: const Key('uploadForm_lecturersInput_textField'),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    letterSpacing: 1.0,
                    height: 1.5,
                  ),
                  hintText: state.optional.lecturers.isNotEmpty
                      ? state.optional.lecturers.value
                      : 'Giảng viên phụ trách',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
