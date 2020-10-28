import 'package:flutter/material.dart';

import '../textfield_container.dart';
import 'action_type.dart';

class PopupInput extends StatelessWidget{
  final hintText;
  final text;
  final ACTION_TYPE action;
  final title;
  final Function callback;

  const PopupInput({
    Key key,
    this.title,
    this.hintText,
    this.text,
    this.action, this.callback
}): super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _folderNameController = new TextEditingController();
    if(text != null && text != ""){
      _folderNameController.text = text;
    }
    return AlertDialog(
      title: Center(
        child: Text(title),
      ),
      content: TextFieldContainer(
        borderRadius: 5.0,
        backColor: Colors.grey[200],
        child: TextField(
          controller: _folderNameController,
          cursorColor: Colors.blue[900],
          decoration: InputDecoration(
            icon: null,
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding:
          EdgeInsets.only(right: 5, bottom: 5),
          child: Row(
            children: [
              GestureDetector(
                child: Text(
                  action.convertToString[0],
                  style: TextStyle(
                      color: Colors.blue[900]),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                child: Text(
                  action.convertToString[1],
                  style: TextStyle(
                      color: Colors.blue[900]),
                ),
                onTap: () {
                  callback(_folderNameController.text);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}