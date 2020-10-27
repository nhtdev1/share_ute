import 'package:flutter/material.dart';
import 'package:share_ute/views/intro_pages/components/card_view.dart';

enum TYPE_TRAINING {
  NONE,
  CLC,
  DAI_TRA,
}

class FirstView extends StatefulWidget {
  Function onChose;
  TYPE_TRAINING curType;
  FirstView({Key key, this.onChose, this.curType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FirstViewState();
  }
}

class _FirstViewState extends State<FirstView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
                child: Text(
              "Bạn Thuộc Hệ Đào Tạo Nào Sau Đây???",
              style: TextStyle(fontSize: 30, color: Colors.white),
              textAlign: TextAlign.center,
            ))),
        Container(
          width: size.width,
          padding: EdgeInsets.only(bottom: 20),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: CardView(
                    width: size.width * 0.4,
                    height: size.width * 0.3,
                    isActivate: widget.curType == TYPE_TRAINING.CLC,
                    content: "Chất Lượng Cao",
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    setState(() {
                      widget.curType = TYPE_TRAINING.CLC;
                    });
                    widget.onChose(TYPE_TRAINING.CLC);
                  },
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                GestureDetector(
                  child: CardView(
                    width: size.width * 0.4,
                    height: size.width * 0.3,
                    isActivate: widget.curType == TYPE_TRAINING.DAI_TRA,
                    content: "Đại Trà",
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    setState(() {
                      widget.curType = TYPE_TRAINING.DAI_TRA;
                    });
                    widget.onChose(TYPE_TRAINING.DAI_TRA);
                  },
                ),
                // SizedBox(
                //   width: size.width * 0.4,
                //   height: size.width * 0.3,
                //   child: GestureDetector(
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(30)),
                //         color: Colors.white,
                //         border: widget.curType == TYPE_TRAINING.CLC? Border.all(
                //           color: Colors.blue,
                //           width: 2
                //         ): null,
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.grey.withOpacity(0.5),
                //             spreadRadius: 5,
                //             blurRadius: 7,
                //             offset: Offset(0, 3), // changes position of shadow
                //           ),
                //         ],
                //       ),
                //       child: Center(
                //         child: Text(
                //           "Chất Lượng Cao",
                //           style: TextStyle(fontSize: 20),
                //         ),
                //       ),
                //     ),
                //     onTap: () {
                //       setState(() {
                //         widget.curType = TYPE_TRAINING.CLC;
                //       });
                //       widget.onChose(TYPE_TRAINING.CLC);
                //     },
                //   ),
                // ),
                // SizedBox(
                //   width: size.width * 0.1,
                // ),
                // SizedBox(
                //   width: size.width * 0.4,
                //   height: size.width * 0.3,
                //   child: GestureDetector(
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(30)),
                //         color: Colors.white,
                //         border: widget.curType == TYPE_TRAINING.DAI_TRA
                //             ? Border.all(color: Colors.blue, width: 2)
                //             : null,
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.grey.withOpacity(0.5),
                //             spreadRadius: 5,
                //             blurRadius: 7,
                //             offset: Offset(0, 3), // changes position of shadow
                //           ),
                //         ],
                //       ),
                //       child: Center(
                //         child: Text(
                //           "Đại Trà",
                //           style: TextStyle(fontSize: 20),
                //         ),
                //       ),
                //     ),
                //     onTap: () {
                //       setState(() {
                //         widget.curType = TYPE_TRAINING.DAI_TRA;
                //       });
                //       widget.onChose(TYPE_TRAINING.DAI_TRA);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image(
                image: AssetImage(
                  'assets/images/intro_01.png',
                ),
                height: 150.0,
                width: 150.0,
              ),
            ],
          ),
        )
      ],
    );
  }
}
