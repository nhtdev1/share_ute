import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/authentication/authentication.dart';

class LockUserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Tài khoản của bạn',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.5,
                  height: 1.5,
                ),
              ),
              Text(
                'đã bị khóa vĩnh viễn',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.5,
                  height: 1.5,
                ),
              ),
              Text(
                'vì vi phạm chính sách của chúng tôi',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 1.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  primary: Colors.blueAccent,
                ),
                onPressed: () {
                  context.read<AuthenticationBloc>().logOut();
                },
                child: Text(
                  'Tiếp tục với tài khoản mới',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
