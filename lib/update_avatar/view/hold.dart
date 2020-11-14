import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAvatarPage extends StatelessWidget {
  const UpdateAvatarPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UpdateAvatarPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageCapture(),
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Row(
              children: [
                FlatButton(
                  onPressed: _cropImage,
                  child: Icon(Icons.crop),
                ),
                FlatButton(
                  onPressed: _clearImage,
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
            Uploader(file: _imageFile),
          ]
        ],
      ),
    );
  }

  // Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final selected = await ImagePicker().getImage(source: source);

    setState(() {
      _imageFile = File(selected.path);
    });
  }

  // Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  // Remove Image
  void _clearImage() {
    setState(() {
      _imageFile = null;
    });
  }
}

class Uploader extends StatefulWidget {
  Uploader({Key key, this.file}) : super(key: key);

  final File file;

  @override
  _UploaderSate createState() => _UploaderSate();
}

class _UploaderSate extends State<Uploader> {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  UploadTask _uploadTask;

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<TaskSnapshot>(
        stream: _uploadTask.snapshotEvents,
        builder: (context, asyncSnapshot) {
          TaskSnapshot snapshot = asyncSnapshot.data;
          TaskState state = snapshot?.state;
          if (asyncSnapshot.hasError) {
            Text('Đã có lỗi xảy ra');
          }
          double progressPercent = snapshot != null
              ? snapshot.bytesTransferred / snapshot.totalBytes
              : 0;
          return Column(
            children: [
              if (state == TaskState.success) Text('Cập nhật thành công'),
              if (state == TaskState.paused)
                FlatButton(
                  onPressed: _uploadTask.resume,
                  child: Icon(Icons.play_arrow),
                ),
              if (state == TaskState.running)
                FlatButton(
                  onPressed: _uploadTask.pause,
                  child: Icon(Icons.pause),
                ),
              LinearProgressIndicator(
                value: progressPercent,
              ),
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(
        onPressed: _startUpload,
        icon: Icon(Icons.cloud_upload),
        label: Text('Upload to Firebase'),
      );
    }
  }

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';
    setState(() {
      _uploadTask = _firebaseStorage.ref().child(filePath).putFile(widget.file);
    });
  }
}
