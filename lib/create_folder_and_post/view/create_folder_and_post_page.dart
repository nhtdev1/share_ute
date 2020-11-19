import 'package:flutter/material.dart';
import 'package:share_ute/upload_post/upload_post.dart';

class CreateFolderAndPostPage extends StatelessWidget {
  const CreateFolderAndPostPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Tạo mới",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            ),
                          ),
                          child: Icon(
                            Icons.create_new_folder_outlined,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "Thư mục",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            ),
                          ),
                          child: Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "Tải lên",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        UploadPostPage.route(),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
