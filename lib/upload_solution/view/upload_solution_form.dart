import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upload_solution/upload_solution.dart';

class UploadSolutionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadSolutionCubit, UploadSolutionState>(
      listener: (context, state) {
        if (state.uploadSolutionProgress ==
            UploadSolutionProgress.submissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                elevation: 10.0,
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Tạo đáp án thất bại!',
                ),
              ),
            );
        } else if (state.uploadSolutionProgress ==
            UploadSolutionProgress.submissionSuccess) {
          Navigator.pop(context);
        } else if (state.fileStatus == FileStatus.pickedWithOverSize) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                elevation: 10.0,
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Không thể upload file lớn hơn 25mb!',
                ),
              ),
            );
        }
      },
      child: ListView(
        children: [
          const Divider(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              _PostButton(),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          _TitleInput(),
          const Divider(
            height: 1,
          ),
          _PickFile(),
        ],
      ),
    );
  }
}

class _PostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadSolutionCubit, UploadSolutionState>(
      builder: (context, state) {
        if (state.uploadSolutionProgress ==
            UploadSolutionProgress.submissionInProgress) {
          return Row(
            children: [
              CircularProgressIndicator(
                strokeWidth: 1,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          );
        }
        if (state.solution.isNotEmpty)
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              child: Text(
                'Đăng',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                context.read<UploadSolutionCubit>().uploadSolution();
              },
            ),
          );
        return SizedBox();
      },
    );
  }
}

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadSolutionCubit, UploadSolutionState>(
      buildWhen: (previous, current) =>
          previous.solution.title != current.solution.title,
      builder: (context, state) {
        return TextField(
          autofocus: false,
          key: const Key('uploadsolutionForm_titleInput_textField'),
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black54,
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          minLines: 10,
          onChanged: (title) => context
              .read<UploadSolutionCubit>()
              .solutionTitleChanged(title.trim()),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
            hintText: 'Mô tả về đáp án của bạn...',
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}

class _PickFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadSolutionCubit, UploadSolutionState>(
        buildWhen: (previous, current) =>
            previous.fileStatus != current.fileStatus,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Icon(
                  Icons.attach_file,
                  color: Colors.black54,
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 5 / 8,
                    child: Text(
                      state.solution.solutionFile.isNotEmpty
                          ? state.solution.solutionFile.fileName
                          : 'Tải lên đáp án của bạn...',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        letterSpacing: 1.0,
                        height: 1.5,
                      ),
                      maxLines: 5,
                    ),
                  ),
                ),
                onTap: () => context.read<UploadSolutionCubit>().pickFile(),
              ),
              Spacer(),
              state.fileStatus == FileStatus.pickFileInProgress
                  ? CircularProgressIndicator(
                      strokeWidth: 1.5,
                    )
                  : state.solution.solutionFile.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black54,
                          ),
                          onPressed: () =>
                              context.read<UploadSolutionCubit>().clearFile(),
                        )
                      : SizedBox(),
              const SizedBox(
                width: 10,
              ),
            ],
          );
        });
  }
}
