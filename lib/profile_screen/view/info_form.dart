import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';

class InfoForm extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => InfoForm());
  }

  @override
  _InFormState createState() => _InFormState();
}

class _InFormState extends State<InfoForm> {
  String birthday = "10/6/1997";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirestoreUserBloc, FirestoreUserState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1 / 5,
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 16,
                        ),
                        hintText: state.user.name,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1 / 5,
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      state.user.email,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1 / 5,
                      child: Text(
                        'Birthday',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        birthday,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    onTap: () {
                      showPickerDate(context, birthday);
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1 / 5,
                      child: Text(
                        'Mobile',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 16,
                        ),
                        hintText: '+84988419884',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(),
              ),
              Center(
                child: RaisedButton(
                    color: Colors.blue.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'UPDATE INFO',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => InfoForm()));
                    }),
              )
            ],
          ),
        );
      },
    );
  }

  showPickerDate(BuildContext context, String bd) {
    List<int> b = bd.split("/").map<int>((e) => int.parse(e)).toList();
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          value: DateTime(b[2], b[0], b[1]),
        ),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          setState(() {
            birthday = (picker.adapter as DateTimePickerAdapter)
                    .value
                    .month
                    .toString() +
                "/" +
                (picker.adapter as DateTimePickerAdapter).value.day.toString() +
                "/" +
                (picker.adapter as DateTimePickerAdapter).value.year.toString();
          });
        }).showDialog(context);
  }
}
