import 'package:flutter/material.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/download/download.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/post_notification/post_notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/report_post/report_post.dart';

class PostBottomSheet extends StatelessWidget {
  PostBottomSheet({this.post});

  final Post post;
  @override
  Widget build(BuildContext context) {
    final user = context.watch<FirestoreUserBloc>().state.user;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Miêu tả: '),
            ],
          ),
          title: Text('${post.postTitle}'),
        ),
        ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Tên file: '),
            ],
          ),
          title: Text('${post.originalFile.fileName}'),
        ),
        ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Kích thước: '),
            ],
          ),
          title: Text('${post.originalFile.fileSize} kB'),
        ),
        Divider(thickness: 1.5),
        ListTile(
          leading: Icon(Icons.cloud_download_outlined),
          title: Text('Tải xuống'),
          onTap: () {
            if (user.premium == 'false') {
              context.read<NotificationCubit>().premiumRequested();
            } else {
              DownloadCubit.instance.downloadFile(
                url: post.originalFile.path,
                fileName: post.originalFile.fileName,
              );
            }
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.history_outlined),
          title: Text('Xem sau'),
          onTap: () {
            context.read<PostNotificationCubit>().addRecentPost(post);
            context.read<NotificationCubit>().recentPostAdded();
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.report_outlined),
          title: Text('Báo cáo bài viết'),
          onTap: () {
            Navigator.pushReplacement(context, ReportPostPage.route(post));
          },
        ),
      ],
    );
  }
}
