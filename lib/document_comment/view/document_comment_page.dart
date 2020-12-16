import 'package:flutter/material.dart';

class DocumentCommentPage extends StatelessWidget {
  const DocumentCommentPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (context) => const DocumentCommentPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Chưa có bình luận nào'),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Icon(Icons.camera_alt_outlined),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: InkWell(
                child: TextFormField(
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'WorkSans',
                  ),
                  decoration: InputDecoration(
                    hintText: "Thêm bình luận...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(Icons.gif_outlined),
            const SizedBox(
              width: 10,
            ),
            Icon(Icons.emoji_emotions_outlined),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
