import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upload_post/upload_post.dart';
import 'package:share_ute/upload_post/view/upload_tags_view.dart';

class UploadPostForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadPostCubit, UploadPostState>(
      listener: (context, state) {
        if (state.postStatus == UploadPostStatus.error) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                elevation: 10.0,
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                content: Text('Tạo bài đăng thất bại!'),
              ),
            );
        } else if (state.postStatus == UploadPostStatus.success) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                elevation: 10.0,
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                content: Text('Tạo bài đăng thành công!'),
              ),
            );
        } else if (state.postStatus == UploadPostStatus.pickedOverFileSize) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                elevation: 10.0,
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                content: Text('Không thể upload file lớn hơn 20mb!'),
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
            ],
          ),
          _TitleInput(),
          const Divider(
            height: 1,
          ),
          _PickFile(),
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
          previous.post.postAccessModifiers != current.post.postAccessModifiers,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: DropdownButton<String>(
            value: state.post.postAccessModifiers.public
                ? 'Công khai'
                : 'Riêng tư',
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
        if (state.postStatus == UploadPostStatus.running) {
          return SizedBox(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
            height: 20,
            width: 20,
          );
        }
        return state.post.isNotEmpty
            ? Padding(
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
              )
            : Container();
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
            color: Colors.black87,
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          minLines: 10,
          onChanged: (title) =>
              context.read<UploadPostCubit>().postTitleChanged(title),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 20,
            ),
            hintText: 'Mô tả về tài liệu của bạn...',
            fillColor: Colors.white,
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          ),
        );
      },
    );
  }
}

class _PickFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
        buildWhen: (previous, current) =>
            previous.post.file != current.post.file,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Icon(Icons.attach_file),
              ),
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      state.post.file.isNotEmpty
                          ? state.post.file.fileName.value
                          : 'Chọn tài liệu',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        letterSpacing: 1.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                  onTap: () => context.read<UploadPostCubit>().pickFile()),
              Spacer(),
              if (state.post.file.isNotEmpty)
                IconButton(
                  icon: Icon(
                    Icons.clear,
                  ),
                  onPressed: () => context.read<UploadPostCubit>().clearFile(),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Icon(Icons.label_outline),
              ),
              Expanded(
                child: GestureDetector(
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    children: [
                      _buildTags(state, context),
                      if (!state.post.postTags.value.isNotEmpty)
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
                              )),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  _buildTags(UploadPostState state, BuildContext context) {
    List<Widget> chips = List();
    state.post.postTags.value.forEach((element) {
      chips.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: Chip(
            deleteIconColor: Colors.white,
            onDeleted: () {
              List<String> temp = [];
              state.post.postTags.value.forEach((element) {
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
        buildWhen: (previous, current) => previous.optional != current.optional,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Icon(Icons.more_horiz_outlined),
              ),
              Expanded(
                child: GestureDetector(
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    children: [
                      if (!state.post.postTags.value.isNotEmpty)
                        Container(
                          child: Text(
                            'Thêm thông tin (không bắt buộc)',
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
        });
  }
}
