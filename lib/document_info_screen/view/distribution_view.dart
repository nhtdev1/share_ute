import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/document_info_screen/document_info_screen.dart';

class DistributionView extends StatefulWidget {
  @override
  _DistributionViewState createState() => _DistributionViewState();
}

class _DistributionViewState extends State<DistributionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: Distribution.randomList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              child: Container(
                decoration: BoxDecoration(
                    color:  CupertinoColors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.systemGrey,
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        )
                      ]),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(60.0)),
                          child: Image.network(
                              Distribution.randomList[index].userUrl)),
                    ),
                    title: Text(
                      Distribution.randomList[index].title,
                      style: TextStyle(
                        color: CupertinoColors.label,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      Distribution.randomList[index].dateCreated,
                      style: TextStyle(color: CupertinoColors.secondaryLabel),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(const IconData(0xf442,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage)),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          Distribution.randomList[index].vote,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )),
              ),
            );
          }),
    );
  }
}
