import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/update_info/update_info.dart';
import 'package:formz/formz.dart';

class UpdateInfoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateInfoCubit, UpdateInfoState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                elevation: 10.0,
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                content: Text('Cập nhật thông tin thất bại'),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                elevation: 10.0,
                backgroundColor: Colors.blue,
                behavior: SnackBarBehavior.floating,
                content: Text('Cập nhật thông tin thành công'),
              ),
            );
        }
      },
      child: Container(
        color: Colors.white,
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: ListView(
            children: [
              _NameInput(),
              Divider(),
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
                      context.watch<FirestoreUserBloc>().state.user.email ==
                              null
                          ? 'Không rõ'
                          : context.watch<FirestoreUserBloc>().state.user.email,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              _BirthdayPicker(),
              Divider(),
              _MobileInput(),
              Divider(),
              _UpdateButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateInfoCubit, UpdateInfoState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1 / 5,
                child: Text(
                  'Tên',
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
                style: TextStyle(
                  fontSize: 16,
                ),
                key: const Key('updateForm_nameInput_textField'),
                onChanged: (name) =>
                    context.read<UpdateInfoCubit>().nameChanged(name),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: state.name.value,
                    errorText: state.name.invalid ? 'tên không hợp lệ' : null,
                    border: InputBorder.none),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BirthdayPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateInfoCubit, UpdateInfoState>(
      buildWhen: (previous, current) => previous.birthday != current.birthday,
      builder: (context, state) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1 / 5,
                child: Text(
                  'Sinh nhật',
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
                  state.birthday.isEmpty ? 'Không rõ' : state.birthday.value,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              onTap: () {
                showPickerDate(context, state.birthday.value);
              },
            )
          ],
        );
      },
    );
  }

  showPickerDate(BuildContext context, String bd) {
    final now = DateTime.now();
    if (bd == '')
      bd = now.day.toString() +
          "/" +
          now.month.toString() +
          "/" +
          now.year.toString();
    List<int> b = bd.split("/").map<int>((e) => int.parse(e)).toList();
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          value: DateTime(b[2], b[0], b[1]),
        ),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          final birthday = (picker.adapter as DateTimePickerAdapter)
                  .value
                  .month
                  .toString() +
              "/" +
              (picker.adapter as DateTimePickerAdapter).value.day.toString() +
              "/" +
              (picker.adapter as DateTimePickerAdapter).value.year.toString();
          context.read<UpdateInfoCubit>().birthdayChanged(birthday);
        }).showDialog(context);
  }
}

class _MobileInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateInfoCubit, UpdateInfoState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1 / 5,
                child: Text(
                  'Điện thoại',
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
                style: TextStyle(
                  fontSize: 16,
                ),
                key: const Key('updateForm_mobileInput_textField'),
                onChanged: (mobile) =>
                    context.read<UpdateInfoCubit>().phoneChanged(mobile),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: state.phone.value,
                    errorText:
                        state.phone.invalid ? 'số điện thoại đang trống' : null,
                    border: InputBorder.none),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _UpdateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateInfoCubit, UpdateInfoState>(
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return Center(
            child: const CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }
        if (state.status.isValidated &&
            state.infoStatus == InfoStatus.changed) {
          return Center(
            child: ElevatedButton(
              key: const Key('updateForm_continue_raisedButton'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              child: Text(
                'Cập nhật',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => context.read<UpdateInfoCubit>().updateUser(),
            ),
          );
        }
        return Container();
      },
    );
  }
}
