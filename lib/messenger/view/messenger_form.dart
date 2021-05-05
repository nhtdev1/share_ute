import 'package:flutter/material.dart';
import 'package:share_ute/chat/chat.dart';
import 'package:share_ute/messenger/messenger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MessengerForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerCubit, MessengerState>(
      builder: (context, state) {
        if (state.query.isNotEmpty) {
          return _QueryResult(
              users: context.watch<MessengerCubit>().getUsersByQuery());
        }
        return ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: state.rooms.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  ChatPage.route(room: state.rooms[index]),
                );
              },
              child: _ConversationWidget(
                friendPhotoUrl: state.rooms[index].friendPhotoUrl,
                friendName: state.rooms[index].friendName,
              ),
            );
          },
        );
      },
    );
  }
}

class _QueryResult extends StatelessWidget {
  _QueryResult({this.users});

  final List<User> users;
  @override
  Widget build(BuildContext context) {
    if (users.isEmpty)
      return Center(
        child: Text("Không tìm thấy người dùng của bạn"),
      );
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final room = await context
                            .read<MessengerCubit>()
                            .findRoomWith(users[index]);
                        Navigator.push(
                          context,
                          ChatPage.route(room: room),
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(60)),
                          child: Image.network(users[index].photo),
                        ),
                      ),
                    ),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(users[index].name)],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ConversationWidget extends StatelessWidget {
  _ConversationWidget({
    this.friendPhotoUrl,
    this.friendName,
  });
  final String friendPhotoUrl;
  final String friendName;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    child: Image.network(friendPhotoUrl),
                  ),
                ),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(friendName),
                const SizedBox(height: 3),
                Text('You: Tài liệu hay'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
