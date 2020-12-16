import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/document_comment/document_comment.dart';
import 'package:share_ute/document_info/document_info.dart';
import 'package:share_ute/document_solution/document_solution.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/solution_notification/solution_notification.dart';

class DocumentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CupertinoColors.white,
            leading: CupertinoButton(
              child: Icon(
                const IconData(0xf4fd,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
                color: CupertinoColors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
              indicatorColor: CupertinoColors.activeBlue,
              tabs: [
                _InfoTab(),
                _SolutionTab(),
                _CommentTab(),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const DocumentInfoPage(),
              const DocumentSolutionPage(),
              const DocumentCommentPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        const IconData(0xf62d,
            fontFamily: CupertinoIcons.iconFont,
            fontPackage: CupertinoIcons.iconFontPackage),
        color: CupertinoColors.darkBackgroundGray,
      ),
    );
  }
}

class _SolutionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolutionNotificationCubit, SolutionNotificationState>(
      buildWhen: (previous, current) =>
          previous.recentSolutionTotal != current.recentSolutionTotal,
      builder: (context, state) {
        return Tab(
          icon: state.recentSolutionTotal > 3
              ? Badge(
                  position: BadgePosition.topEnd(top: -10, end: -10),
                  shape: BadgeShape.square,
                  borderRadius: BorderRadius.circular(3),
                  badgeContent: Text(
                    '3+',
                    style: TextStyle(
                      fontSize: 9,
                    ),
                  ),
                  child: Icon(
                    const IconData(0xf6dd,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: CupertinoColors.darkBackgroundGray,
                  ),
                )
              : Icon(
                  const IconData(0xf6dd,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage),
                  color: CupertinoColors.darkBackgroundGray,
                ),
        );
      },
    );
  }
}

class _CommentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        const IconData(0xf5a4,
            fontFamily: CupertinoIcons.iconFont,
            fontPackage: CupertinoIcons.iconFontPackage),
        color: CupertinoColors.darkBackgroundGray,
      ),
    );
  }
}
