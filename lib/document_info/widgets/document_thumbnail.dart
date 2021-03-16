import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/play_video/play_video.dart';

class DocumentThumbnail extends StatelessWidget {
  DocumentThumbnail(this.post);

  final Post post;
  @override
  Widget build(BuildContext context) {
    if (post.originalFile.fileExtension.contains('mp4')) {
      return PlayVideoPage(post);
    }
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 6 / 5,
        child: Container(
          padding: const EdgeInsets.all(75.0),
          child: SvgPicture.asset(
            post.originalFile.fileExtension.contains('doc')
                ? 'assets/images/thumbnail_word.svg'
                : post.originalFile.fileExtension.contains('xls')
                    ? 'assets/images/thumbnail_xls.svg'
                    : post.originalFile.fileExtension.contains('ppt')
                        ? 'assets/images/thumbnail_ppt.svg'
                        : post.originalFile.fileExtension.contains('pdf')
                            ? 'assets/images/thumbnail_pdf.svg'
                            : 'assets/images/thumbnail_mp4.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),
      onTap: () {
        _openFile(post.originalFile.path);
      },
    );
  }

  Future<void> _openFile(String path) async {
    await PdftronFlutter.initialize('');
    await PdftronFlutter.version;
    await PdftronFlutter.openDocument(path);
  }
}
