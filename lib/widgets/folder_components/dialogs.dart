import 'package:flutter/material.dart';
import 'package:share_ute/widgets/folder_components/action_type.dart';

class MyDialogs {
  static void showDialogConfirm(context, title, ACTION_TYPE action, Function callback, [specialParameter]) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 120,
            child: SizedBox.expand(
                child: Material(
              type: MaterialType.transparency,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Text(
                            action.convertToString[0],
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                          onTap: () => Navigator.pop(_),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          child: Text(
                            action.convertToString[1],
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                          onTap: () {
                            Navigator.pop(_);
                            callback(specialParameter);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
