import 'package:flutter/material.dart';
import 'package:share_ute/send_message/send_message.dart';

enum MessagePosition {
  alone,
  top,
  middle,
  bottom,
}

class MessengerScreen extends StatelessWidget {
  final controller = ScrollController();

  static const List<String> messages = [
    "_Uk, tự nhiên dạo này mệt, khó chịu vl",
    "Ừ. Suy nghĩ nhiều quá",
    "H trúng tòe vé số 2 tỉ là nó khỏe à kk",
    "_Mà éo biết có ai chơi bùa gì gia đình không",
    "_Sao gặp toàn gì đâu",
    "Chắc năm nay hạn",
    "Kêu má m đi xem bói s",
    "Mà ráng nay nó làm có tiền chưa",
    "_Di r",
    "_Mà bả kêu có gì đâu",
    "_Chán quá",
    "Ừ coi 2 3 ông gì đó cho chính xác",
    "_Like",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Stack(
              children: [
                //avatar
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
                      child: Image.network(
                          'https://randomuser.me/api/portraits/men/79.jpg'),
                    ),
                  ),
                ),
                // active circle icon
                Positioned.fill(
                  bottom: 2,
                  right: 2,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            // username
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thanh Tiên',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.normal),
                ),
                Text(
                  'Active Now',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontStyle: FontStyle.normal),
                ),
              ],
            )
          ],
        ),
      ),
      body: WillPopScope(
        child: Stack(
          children: [
            Column(
              children: [
                buildMessages(context),
                SendMessagePage(),
              ],
            )
          ],
        ),
        onWillPop: onBackPress,
      ),
    );
  }

  Future<bool> onBackPress() {
    return Future.value(false);
  }

  Widget buildMessages(BuildContext chatViewContext) {
    return Flexible(
        child: ListView.builder(
      controller: controller,
      itemCount: MessengerScreen.messages.length,
      itemBuilder: (context, index) {
        final topContent =
            index == 0 ? "" : MessengerScreen.messages[index - 1];
        final middleContent = MessengerScreen.messages[index];
        final bottomContent = index == MessengerScreen.messages.length - 1
            ? ""
            : MessengerScreen.messages[index + 1];

        return buildItem(
            index, topContent, middleContent, bottomContent, chatViewContext);
      },
    ));
  }

  Widget buildItem(
    int index,
    String topContent,
    String middleContent,
    String bottomContent,
    BuildContext context,
  ) {
    if (middleContent.contains("_")) {
      return buildRightItem(
        topContent,
        middleContent.replaceAll("_", ""),
        bottomContent,
        context,
      );
    } else {
      return buildLeftItem(
        topContent,
        middleContent,
        bottomContent,
      );
    }
  }

  int _getPositionOfRightMessage(
    String topContent,
    String middleContent,
    String bottomContent,
  ) {
    if (topContent.contains("_") && bottomContent.contains("_")) {
      return 2;
    }

    if (topContent.contains("_")) {
      return 3;
    }

    if (bottomContent.contains("_")) {
      return 1;
    }
    return 0;
  }

  int _getPositionOfLeftMessage(
    String topContent,
    String middleContent,
    String bottomContent,
  ) {
    if (!topContent.contains("_") && !bottomContent.contains("_")) {
      return 2;
    }

    if (!topContent.contains("_")) {
      return 3;
    }

    if (!bottomContent.contains("_")) {
      return 1;
    }
    return 0;
  }

  BorderRadius _getBorderRadiusByPositionOfRightMessage(int pos) {
    if (pos == 1) {
      return BorderRadius.only(
        topRight: Radius.circular(60),
        topLeft: Radius.circular(60),
        bottomLeft: Radius.circular(60),
      );
    }
    if (pos == 2) {
      return BorderRadius.only(
        topLeft: Radius.circular(60),
        bottomLeft: Radius.circular(60),
      );
    }
    if (pos == 3) {
      return BorderRadius.only(
        topLeft: Radius.circular(60),
        bottomLeft: Radius.circular(60),
        bottomRight: Radius.circular(60),
      );
    }
    return BorderRadius.all(Radius.circular(60));
  }

  BorderRadius _getBorderRadiusByPositionOfLeftMessage(int pos) {
    if (pos == 1) {
      return BorderRadius.only(
        topRight: Radius.circular(60),
        topLeft: Radius.circular(60),
        bottomRight: Radius.circular(60),
      );
    }
    if (pos == 2) {
      return BorderRadius.only(
        topRight: Radius.circular(60),
        bottomRight: Radius.circular(60),
      );
    }
    if (pos == 3) {
      return BorderRadius.only(
        topRight: Radius.circular(60),
        bottomLeft: Radius.circular(60),
        bottomRight: Radius.circular(60),
      );
    }
    return BorderRadius.all(Radius.circular(60));
  }

  Widget buildRightItem(
    String topContent,
    String middleContent,
    String bottomContent,
    BuildContext context,
  ) {
    final pos = _getPositionOfRightMessage(
      topContent,
      middleContent,
      bottomContent,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 3 / 4),
          child: Container(
            child: Text(
              middleContent,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: _getBorderRadiusByPositionOfRightMessage(pos),
              color: Colors.blueAccent,
            ),
            margin: EdgeInsets.only(
              right: 30,
              bottom: (pos == 0 || pos == 3) ? 10 : 3,
            ),
          ),
        )
      ],
    );
  }

  Widget buildLeftItem(
    String topContent,
    String middleContent,
    String bottomContent,
  ) {
    final pos = _getPositionOfLeftMessage(
      topContent,
      middleContent,
      bottomContent,
    );

    return Row(
      children: [
        const SizedBox(width: 10),
        Stack(
          children: [
            //avatar
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: (pos == 0 || pos == 3)
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60)),
                        child: Image.network(
                            'https://randomuser.me/api/portraits/men/79.jpg'),
                      )
                    : null,
              ),
            ),
            // active circle icon
            if (pos == 0 || pos == 3)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        )),
                  ),
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                middleContent,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: _getBorderRadiusByPositionOfLeftMessage(pos),
                color: Colors.grey.withOpacity(0.3),
              ),
              margin: EdgeInsets.only(
                left: 10,
                bottom: (pos == 0 || pos == 3) ? 10 : 3,
              ),
            )
          ],
        )
      ],
    );
  }
}
