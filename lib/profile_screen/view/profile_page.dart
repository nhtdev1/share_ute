import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/update_avatar/update_avatar.dart';
import 'package:share_ute/update_bio/update_bio.dart';
import 'package:share_ute/update_info/update_info.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirestoreUserBloc, FirestoreUserState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 1 / 4),
            child: AppBar(
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [Colors.blue, Colors.red],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    bottom: 20.0,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage(
                              state.user.photo),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          state.user.name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: ListTile(
                  title: Text('Cập nhật thông tin'),
                  onTap: () {
                    Navigator.push(
                      context,
                      UpdateInfoPage.route(),
                    );
                  },
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.1,
                    ),
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text('Đổi ảnh đại diện'),
                  onTap: (){
                    Navigator.push(
                      context,
                      UpdateAvatarPage.route(),
                    );
                  },
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.1,
                    ),
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text('Cập nhật sở thích'),
                  onTap: () {
                    Navigator.push(
                      context,
                      UpdateBioPage.route(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
