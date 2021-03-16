import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upgrade/upgrade.dart';
import 'package:share_ute/upload_post/upload_post.dart';
import 'package:share_ute/upload_post/view/upload_tags_view.dart';

class UploadPostForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadPostCubit, UploadPostState>(
      listener: (context, state) {
        if (state.uploadPostProgress == UploadPostProgress.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                elevation: 10.0,
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Tạo bài đăng thất bại!',
                ),
              ),
            );
        } else if (state.uploadPostProgress ==
            UploadPostProgress.submissionSuccess) {
          Navigator.pop(context);
        } else if (state.originalFileStatus == FileStatus.pickedWithOverSize) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 10.0,
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Tài khoản chỉ upload file nhỏ hơn 10mb',
                ),
                action: SnackBarAction(
                  label: 'Nâng cấp',
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context, UpgradePage.route());
                  },
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
              _ModifiersDropDown(),
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
          _PickOriginalFile(),
          const Divider(
            height: 1,
          ),
          _TagsRow(),
          const Divider(
            height: 1,
          ),
          _OptionalRow(),
        ],
      ),
    );
  }
}

class _ModifiersDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
      buildWhen: (previous, current) =>
          previous.post.public != current.post.public,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: DropdownButton<String>(
            value: state.post.public == 'true' ? 'Công khai' : 'Riêng tư',
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 16,
            style: TextStyle(color: Colors.blue),
            onChanged: (value) =>
                context.read<UploadPostCubit>().accessModifiersChanged(value),
            items: <String>['Công khai', 'Riêng tư']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _PostButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
      builder: (context, state) {
        if (state.uploadPostProgress ==
            UploadPostProgress.submissionInProgress) {
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
        if (state.post.isNotEmpty)
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              child: Text(
                'Đăng',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                context.read<UploadPostCubit>().uploadPost();
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
    return BlocBuilder<UploadPostCubit, UploadPostState>(
      buildWhen: (previous, current) =>
          previous.post.postTitle != current.post.postTitle,
      builder: (context, state) {
        return TextField(
          autofocus: false,
          key: const Key('uploadPostForm_titleInput_textField'),
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black54,
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          minLines: 10,
          onChanged: (title) =>
              context.read<UploadPostCubit>().postTitleChanged(title.trim()),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
            hintText: 'Mô tả về tài liệu của bạn...',
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

class _PickOriginalFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
        buildWhen: (previous, current) =>
            previous.originalFileStatus != current.originalFileStatus,
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
                      state.post.originalFile.isNotEmpty
                          ? state.post.originalFile.fileName
                          : 'Chọn tài liệu',
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
                onTap: () => context.read<UploadPostCubit>().pickOriginalFile(),
              ),
              Spacer(),
              state.originalFileStatus == FileStatus.pickFileInProgress
                  ? CircularProgressIndicator(
                      strokeWidth: 1.5,
                    )
                  : state.post.originalFile.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black54,
                          ),
                          onPressed: () => context
                              .read<UploadPostCubit>()
                              .clearOriginalFile(),
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

class _TagsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
        buildWhen: (previous, current) =>
            previous.post.postTags != current.post.postTags,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Icon(
                  Icons.label_outline,
                  color: Colors.black54,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      _buildTags(state, context),
                      if (state.post.postTags.isEmpty)
                        Container(
                          child: Text(
                            'Gán nhãn cho tài liệu giúp nó được tìm kiếm dễ dàng hơn',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              letterSpacing: 1.0,
                              height: 1.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<UploadPostCubit>(),
                          child: const UploadTagsView(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  _buildTags(UploadPostState state, BuildContext context) {
    List<Widget> chips = [];
    state.post.postTags.forEach((element) {
      chips.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: Chip(
            deleteIconColor: Colors.white,
            onDeleted: () {
              List<String> temp = [];
              state.post.postTags.forEach((element) {
                temp.add(element);
              });
              temp.remove(element);
              context.read<UploadPostCubit>().postTagsChanged(temp);
            },
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.lightBlueAccent,
            label: Text(
              element,
            ),
          ),
        ),
      );
    });

    return Wrap(
      children: chips,
    );
  }
}

class _OptionalRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
      buildWhen: (previous, current) => previous.post != current.post,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1 / 8,
              child: Icon(
                Icons.more_horiz_outlined,
                color: Colors.black54,
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: ListView(
                  padding: const EdgeInsets.all(10.0),
                  shrinkWrap: true,
                  children: [
                    Container(
                      child: Text(
                        state.post.hasOptionalInfo
                            ? 'Đã bổ sung thêm thông tin'
                            : 'Thêm thông tin (không bắt buộc)',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          letterSpacing: 1.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<UploadPostCubit>(),
                        child: const UploadOptionalView(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
