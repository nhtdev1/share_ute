import 'package:flutter/material.dart';

import 'components/card_view.dart';

class SecondView extends StatefulWidget {
  @required
  List<String> major;
  SecondView({Key key, this.major}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SecondViewState();
  }
}

class _SecondViewState extends State<SecondView> {
  var currentSelectionIndex = -1;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image(
          image: AssetImage(
            'assets/images/logo.png',
          ),
          height: 60.0,
          width: 60.0,
        ),
        Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20),),
            Text(
              "Bạn Học Ngành Nào Sau Đây???",
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Padding(padding: EdgeInsets.only(top: 20),),
            Expanded(
              child: Container(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  shrinkWrap: true,
                  itemCount: widget.major.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                          child: CardView(
                            width: size.width * 0.3,
                            height: size.width * 0.1,
                            isActivate: index == currentSelectionIndex,
                            content: widget.major[index],
                            textStyle: TextStyle(fontSize: 16),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            currentSelectionIndex = index;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
