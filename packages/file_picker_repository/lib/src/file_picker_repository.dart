import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'models/file.dart' as file_picker;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerRepository {
  final imagePicker = ImagePicker();

  Future<PickedFile> pickImageFromCamera() async {
    return imagePicker.getImage(source: ImageSource.camera);
  }

  Future<PickedFile> pickImageFromGallery() async {
    return imagePicker.getImage(source: ImageSource.gallery);
  }

  Future<File> cropImage(String path) async {
    return ImageCropper.cropImage(
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
