import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';

class ProfileForm extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirestoreUserBloc,FirestoreUserState>(
      buildWhen: (previous,current) => previous.user != current.user,
      builder: (context,state){
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
                          backgroundColor: Colors.redAccent,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          state.user.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
                  title: Text('Infor'),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => BlocProvider.value(
                    //       value: context.bloc<FirestoreUserBloc>(),
                    //       child: InfoForm(),
                    //     ),
                    //   ),
                    // );
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
                  title: Text('Change your avatar'),
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
                  title: Text('Update Bio'),
                  onTap: (){
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => BioForm()),
                    // );
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