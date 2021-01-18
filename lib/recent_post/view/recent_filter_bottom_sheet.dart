import 'package:flutter/material.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/recent_post/recent_post.dart';

class RecentFilterBottomSheet extends StatelessWidget {
  RecentFilterBottomSheet({this.posts, this.sortCallBack});

  final List<Post> posts;
  final Function sortCallBack;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text('Sắp xếp theo'),
        ),
        Divider(thickness: 1.5),
        ListTile(
          title: Text('Tên'),
          onTap: () {
            sortCallBack(SortType.byName);
          },
        ),
        ListTile(
          title: Text('Ngày gần nhất'),
          onTap: () {
            sortCallBack(SortType.byDateCreatedDesc);
          },
        ),
        ListTile(
          title: Text('Ngày cũ nhất'),
          onTap: () {
            sortCallBack(SortType.byDateCreatedAsc);
          },
        ),
        ListTile(
          title: Text('Kích thước file giảm dần'),
          onTap: () {
            sortCallBack(SortType.byFileSizeDesc);
          },
        ),
        ListTile(
          title: Text('Kích thước file tăng dần'),
          onTap: () {
            sortCallBack(SortType.byFileSizeAsc);
          },
        ),
        ListTile(
          title: Text('Lượt tải giảm dần'),
          onTap: () {
            sortCallBack(SortType.byDownloadTotalDesc);
          },
        ),
        ListTile(
          title: Text('Lượt tải tăng dần'),
          onTap: () {
            sortCallBack(SortType.byDownloadTotalAsc);
          },
        ),
      ],
    );
  }
}
