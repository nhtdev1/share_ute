import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/document_solution/models/models.dart';

class DocumentSolutionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: Solution.random.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.0),
              child: Container(
                decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(60.0),
                        ),
                        child: Image.network(
                          Solution.random[index].userUrl,
                        ),
                      ),
                    ),
                    title: Text(
                      Solution.random[index].title,
                      style: TextStyle(
                        color: CupertinoColors.label,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      Solution.random[index].dateCreated,
                      style: TextStyle(color: CupertinoColors.secondaryLabel),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          const IconData(
                            0xf81f,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          Solution.random[index].vote,
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
