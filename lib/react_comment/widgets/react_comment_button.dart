import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/react_comment/react_comment.dart';

class EmotionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactCommentBloc, ReactCommentState>(
      buildWhen: (previous, current) => previous.emotions != current.emotions,
      builder: (context, state) {
        return FlutterReactionButtonCheck(
          onReactionChanged: (reaction, isChecked) {
            context
                .read<ReactCommentBloc>()
                .add(ReactCommentRequested(reaction.id));
          },
          reactions: <Reaction>[
            Reaction(
              id: 1,
              title: _buildTitle('Thích'),
              previewIcon: _buildReactionsPreviewIcon('assets/images/like.gif'),
              icon: _buildReactionsIcon(
                'assets/images/like.png',
                Text(
                  'Thích',
                  style: TextStyle(
                    color: Color(0XFF3b5998),
                  ),
                ),
              ),
            ),
            Reaction(
              id: 2,
              title: _buildTitle('Yêu'),
              previewIcon: _buildReactionsPreviewIcon('assets/images/love.gif'),
              icon: _buildReactionsIcon(
                'assets/images/love.png',
                Text(
                  'Yêu',
                  style: TextStyle(
                    color: Color(0XFFed5168),
                  ),
                ),
              ),
            ),
            Reaction(
              id: 3,
              title: _buildTitle('Ghê'),
              previewIcon: _buildReactionsPreviewIcon('assets/images/wow.gif'),
              icon: _buildReactionsIcon(
                'assets/images/wow.png',
                Text(
                  'Ghê',
                  style: TextStyle(
                    color: Color(0XFFffda6b),
                  ),
                ),
              ),
            ),
            Reaction(
              id: 4,
              title: _buildTitle('Tức'),
              previewIcon:
                  _buildReactionsPreviewIcon('assets/images/angry.gif'),
              icon: _buildReactionsIcon(
                'assets/images/angry.png',
                Text(
                  'Tức',
                  style: TextStyle(
                    color: Color(0XFFffda6b),
                  ),
                ),
              ),
            ),
          ],
          initialReaction: _buildselectedReaction(state),
          selectedReaction: _buildselectedReaction(state),
        );
      },
    );
  }

  Widget _buildReactionsPreviewIcon(String path) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 5),
        child: Image.asset(path, height: 40),
      );

  Widget _buildReactionsIcon(String path, Text text) => Container(
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            Image.asset(path, height: 20),
            const SizedBox(width: 5),
          ],
        ),
      );

  Widget _buildTitle(String title) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  _buildselectedReaction(ReactCommentState state) {
    if (state.userStatus == ReactCommentStatus.reactedWithLike) {
      return Reaction(
          id: 1,
          title: _buildTitle('Thích'),
          previewIcon: _buildReactionsPreviewIcon('assets/images/like.gif'),
          icon: _buildReactionsIcon(
            'assets/images/like.png',
            Text(
              'Thích',
              style: TextStyle(
                color: Color(0XFF3b5998),
              ),
            ),
          ));
    }

    if (state.userStatus == ReactCommentStatus.reactedWithLove) {
      return Reaction(
          id: 2,
          title: _buildTitle('Yêu'),
          previewIcon: _buildReactionsPreviewIcon('assets/images/like.gif'),
          icon: _buildReactionsIcon(
            'assets/images/love.png',
            Text(
              'Yêu',
              style: TextStyle(
                color: Color(0XFF3b5998),
              ),
            ),
          ));
    }
    if (state.userStatus == ReactCommentStatus.reactedWithWow) {
      return Reaction(
          id: 3,
          title: _buildTitle('Ghê'),
          previewIcon: _buildReactionsPreviewIcon('assets/images/like.gif'),
          icon: _buildReactionsIcon(
            'assets/images/wow.png',
            Text(
              'Ghê',
              style: TextStyle(
                color: Color(0XFF3b5998),
              ),
            ),
          ));
    }
    if (state.userStatus == ReactCommentStatus.reactedWithAngry) {
      return Reaction(
          id: 4,
          title: _buildTitle('Tức'),
          previewIcon: _buildReactionsPreviewIcon('assets/images/like.gif'),
          icon: _buildReactionsIcon(
            'assets/images/angry.png',
            Text(
              'Tức',
              style: TextStyle(
                color: Color(0XFF3b5998),
              ),
            ),
          ));
    }

    return Reaction(
      id: 1,
      title: _buildTitle('Thích'),
      previewIcon: _buildReactionsPreviewIcon('assets/images/like.gif'),
      icon: _buildReactionsIcon(
        'assets/images/like_disable.png',
        Text(
          'Thích',
          style: TextStyle(
            color: Color(0XFF3b5998),
          ),
        ),
      ),
    );
  }
}
