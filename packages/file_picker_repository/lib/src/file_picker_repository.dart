import 'package:file_picker/file_picker.dart';
import 'models/file.dart' as file_picker;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerRepository {
  final imagePicker = ImagePicker();

  Future<file_picker.File> pickImageFromCamera() async {
    final result = await imagePicker.getImage(source: ImageSource.camera);
    if (result != null) {
      return file_picker.File(
        path: result.path,
      );
    } else {
      return file_picker.File.empty;
    }
  }

  Future<file_picker.File> pickImageFromGallery() async {
    final result = await imagePicker.getImage(source: ImageSource.gallery);
    if (result != null) {
      final size = await result.readAsBytes();
      return file_picker.File(
        path: result.path,
        fileSize: size.length.toString(),
      );
    } else {
      return file_picker.File.empty;
    }
  }

  Future<file_picker.File> cropImage(String path) async {
    final result = await ImageCropper.cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );

    if (result != null) {
      final size = await result.readAsBytes();
      return file_picker.File(
        path: result.path,
        fileSize: size.length.toString(),
      );
    } else {
      return file_picker.File.empty;
    }
  }

  Future<file_picker.File> pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'xlsx',
        'xls',
        'ppt',
        'pptx',
        'mp4',
      ],
    );
    if (result != null) {
      return file_picker.File(
        path: result.files.single.path,
        fileName: result.files.first.name,
        fileExtension: result.files.first.extension,
        fileSize: result.files.first.size.toString(),
      );
    } else {
      return file_picker.File.empty;
    }
  }
}
