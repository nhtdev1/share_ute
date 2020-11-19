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
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          _PickSolutionFile(),
          const Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          _YearRow(),
          const Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          _SemesterRow(),
          const Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          _CreditsRow(),
          const Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          _MajorRow(),
          const Padding(
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
            previous.post.solutionFile != current.post.solutionFile,
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
                      state.post.solutionFile.isNotEmpty
                          ? state.post.solutionFile.fileName
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
              if (state.post.solutionFile.isNotEmpty)
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey,
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
            previous.post.postYear != current.post.postYear,
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
                    state.post.postYear.isNotEmpty
                        ? state.post.postYear
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
              Spacer(),
              if (state.post.postYear.isNotEmpty)
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  onPressed: () =>
                      context.read<UploadPostCubit>().yearChanged(''),
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
            previous.post.semester != current.post.semester,
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
                color: state.post.semester == element
                    ? Colors.grey.withOpacity(0.2)
                    : null,
              ),
            ),
          ),
          onTap: () {
            if (state.post.semester != element) {
              context.read<UploadPostCubit>().semesterChanged(element);
            } else {
              context.read<UploadPostCubit>().semesterChanged('');
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
            previous.post.credit != current.post.credit,
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
                color: state.post.credit == element
                    ? Colors.grey.withOpacity(0.2)
                    : null,
              ),
            ),
          ),
          onTap: () {
            if (state.post.credit != element) {
              context.read<UploadPostCubit>().creditChanged(element);
            } else {
              context.read<UploadPostCubit>().creditChanged('');
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

class _MajorRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
        buildWhen: (previous, current) =>
            previous.post.major != current.post.major,
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
                    state.post.major.isNotEmpty
                        ? state.post.major
                        : 'Tài liệu thuộc ngành nào?',
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
                        child: const UploadMajorView(),
                      ),
                    ),
                  );
                },
              ),
              Spacer(),
              if (state.post.major.isNotEmpty)
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  onPressed: () =>
                      context.read<UploadPostCubit>().majorChanged(''),
                ),
            ],
          );
        });
  }
}

class _LecturersInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
      buildWhen: (previous, current) =>
          previous.post.lecturer != current.post.lecturer,
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
                onChanged: (value) =>
                    context.read<UploadPostCubit>().lecturerChanged(value),
                key: const Key('uploadForm_lecturersInput_textField'),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    letterSpacing: 1.0,
                    height: 1.5,
                  ),
                  hintText: state.post.lecturer.isNotEmpty
                      ? state.post.lecturer
                      : 'Giảng viên phụ trách',
                  errorText: state.post.lecturer.length > 30
                      ? 'tên không hợp lệ'
                      : null,
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
