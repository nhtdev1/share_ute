import 'package:flutter/material.dart';
import 'package:share_ute/lock_user/view/view.dart';

class LockUserPage extends StatelessWidget {
  const LockUserPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => const LockUserPage());
  }

  @override
  Widget build(BuildContext context) {
    return LockUserForm();
  }
}
