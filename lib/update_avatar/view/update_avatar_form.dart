import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/update_avatar/update_avatar.dart';

class UpdateAvatarForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () =>
                  context.read<UpdateAvatarCubit>().pickImageFromCamera(),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () =>
                  context.read<UpdateAvatarCubit>().pickImageFromGallery(),
            ),
          ],
        ),
      ),
      body: BlocListener<UpdateAvatarCubit, UpdateAvatarState>(
        listener: (context, state) {
          if (state.updateAvatarProgress ==
              UpdateAvatarProgress.submissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  elevation: 10.0,
                  backgroundColor: Colors.blue,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Cập nhật ảnh đại diện thất bại!'),
                ),
              );
          } else if (state.updateAvatarProgress ==
              UpdateAvatarProgress.submissionSuccess) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  elevation: 10.0,
                  backgroundColor: Colors.blue,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Cập nhật ảnh đại diện thành công!'),
                ),
              );
          } else if (state.avatarStatus == AvatarStatus.pickedOverSize) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  elevation: 10.0,
                  backgroundColor: Colors.blue,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Không thể upload ảnh lớn hơn 10mb!'),
                ),
              );
          }
        },
        child: ListView(
          children: [
            _ImageHolder(),
            _ImageTool(),
            Center(
              child: _UploadButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAvatarCubit, UpdateAvatarState>(
      buildWhen: (previous, current) => previous.file != current.file,
      builder: (context, state) {
        return state.file.path.isEmpty
            ? Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 2 / 5),
                child: Center(
                  child: Text(
                    'Vui lòng tải ảnh lên',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            // : Image.file(File(state.avatar.path));
            : Image.file(File(state.file.path));
      },
    );
  }
}

class _ImageTool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAvatarCubit, UpdateAvatarState>(
        buildWhen: (previous, current) =>
            previous.avatarStatus != current.avatarStatus,
        builder: (context, state) {
          return state.file.path.isEmpty
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      onPressed: () =>
                          context.read<UpdateAvatarCubit>().cropImage(),
                      child: Icon(Icons.crop),
                    ),
                    FlatButton(
                      onPressed: () =>
                          context.read<UpdateAvatarCubit>().clearImage(),
                      child: Icon(Icons.clear),
                    ),
                  ],
                );
        });
  }
}

class _UploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAvatarCubit, UpdateAvatarState>(
      builder: (context, state) {
        if (state.updateAvatarProgress ==
            UpdateAvatarProgress.submissionInProgress) {
          return const CircularProgressIndicator(
            strokeWidth: 2,
          );
        } else {
          return state.avatarStatus == AvatarStatus.pickedAcceptableSize ||
                  state.avatarStatus == AvatarStatus.cropped
              ? RaisedButton(
                  highlightElevation: 0.0,
                  elevation: 0.0,
                  color: Colors.blueAccent,
                  child: const Text(
                    'Cập nhật',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onPressed: state.file.path.isNotEmpty
                      ? () => context.read<UpdateAvatarCubit>().uploadImage()
                      : null,
                )
              : Container();
        }
      },
    );
  }
}
