import 'package:flutter/material.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:post_repository/post_repository.dart';

class DocumentThumbnail extends StatelessWidget {
  DocumentThumbnail(this.post);

  final Post post;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 6 / 5,
        child: Center(
          child: Text(
            'Nhấn vào để mở file...',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
      onTap: () {
        _openFile(post.originalFile.path);
      },
    );
  }

  Future<void> _openFile(String path) async {
    PdftronFlutter.initialize('');
    await PdftronFlutter.version;
    await PdftronFlutter.openDocument(path);
  }
}
