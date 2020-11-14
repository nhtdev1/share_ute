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
          if (state.status == UpdateAvatarStatus.error) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text('Cập nhật ảnh đại diện thất bại!')),
              );
          } else if (state.status == UpdateAvatarStatus.success) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                    content: Text('Cập nhật ảnh đại diện thành công!')),
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
      buildWhen: (previous, current) => previous.avatar != current.avatar,
      builder: (context, state) {
        return state.avatar.path == ''
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
            : Image.file(File(state.avatar.path));
      },
    );
  }
}

class _ImageTool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAvatarCubit, UpdateAvatarState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.avatar.path == ''
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
        if (state.status == UpdateAvatarStatus.running) {
          return const CircularProgressIndicator(
            strokeWidth: 1,
          );
        } else {
          return state.status == UpdateAvatarStatus.picked ||
                  state.status == UpdateAvatarStatus.cropped
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
                  onPressed: state.avatar.path != ''
                      ? () => context.read<UpdateAvatarCubit>().uploadImage()
                      : null,
                )
              : Container();
        }
      },
    );
  }
}
