import 'package:flutter/material.dart';

class EmoijTypeOptionsWidget extends StatelessWidget {
  const EmoijTypeOptionsWidget();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 2.5, color: Colors.blue))),
              child: TextButton(
                child: Text('😀'),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: TextButton(
              child: Text('🐻'),
              onPressed: () {},
            ),
          )),
          Expanded(
              child: Container(
            child: TextButton(
              child: Text('🍔'),
              onPressed: () {},
            ),
          )),
          Expanded(
              child: Container(
            child: TextButton(
              child: Text('⚽'),
              onPressed: () {},
            ),
          )),
          Expanded(
              child: Container(
            child: TextButton(
              child: Text('🚖'),
              onPressed: () {},
            ),
          )),
          Expanded(
            child: Container(
              child: TextButton(
                child: Text('💡'),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TextButton(
                child: Text('❤️'),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TextButton(
                child: Text('🇻🇳'),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TextButton(
                child: Text('🇻🇳'),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
