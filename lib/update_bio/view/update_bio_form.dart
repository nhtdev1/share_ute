import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/update_bio/update_bio.dart';
import 'package:formz/formz.dart';
import 'package:share_ute/update_bio/view/update_hobbies_view.dart';
import 'package:user_repository/user_repository.dart';

class UpdateBioForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateBioCubit, UpdateBioState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Cập nhật thành công')),
              );
          } else if (state.status.isSubmissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Cập nhật thất bại')),
              );
          }
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            _YearRow(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
            _FacultyRow(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
            _MajorRow(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
            _HobbiesRow(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
            Center(
              child: RaisedButton(
                color: Colors.blue.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Cập nhật',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  context.read<UpdateBioCubit>().updateBioUser();
                },
              ),
            ),
          ],
        ));
  }
}

class _YearRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBioCubit, UpdateBioState>(
        buildWhen: (previous, current) =>
            previous.year.value != current.year.value,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 5,
                  child: Text(
                    'Khóa',
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
                    context.watch<UpdateBioCubit>().state.year.value == ''
                        ? 'Không rõ'
                        : context.watch<UpdateBioCubit>().state.year.value,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                              value: context.read<UpdateBioCubit>(),
                              child: const UpdateYearView(),
                            )),
                  );
                },
              ),
            ],
          );
        });
  }
}

class _FacultyRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBioCubit, UpdateBioState>(
        buildWhen: (previous, current) =>
            previous.faculty.value != current.faculty.value,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 5,
                  child: Text(
                    'Khoa',
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
                    context.watch<UpdateBioCubit>().state.faculty.value == ''
                        ? 'Không rõ'
                        : context.watch<UpdateBioCubit>().state.faculty.value,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                              value: context.read<UpdateBioCubit>(),
                              child: const UpdateFacultyView(),
                            )),
                  );
                },
              ),
            ],
          );
        });
  }
}

class _MajorRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBioCubit, UpdateBioState>(
        buildWhen: (previous, current) =>
            previous.major.value != current.major.value,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 5,
                  child: Text(
                    'Ngành',
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
                    context.watch<UpdateBioCubit>().state.major.value == ''
                        ? 'Không rõ'
                        : context.watch<UpdateBioCubit>().state.major.value,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                              value: context.read<UpdateBioCubit>(),
                              child: const UpdateMajorView(),
                            )),
                  );
                },
              ),
            ],
          );
        });
  }
}

class _HobbiesRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBioCubit, UpdateBioState>(
        buildWhen: (previous, current) =>
            previous.hobbies.value != current.hobbies.value,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 5,
                  child: Text(
                    'Quan tâm',
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
              Expanded(
                child: GestureDetector(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _buildHobbies(state, context),
                      if (!state.hobbies.value.isNotEmpty)
                        Container(
                          child: Text(
                            'Chọn chủ đề bạn quan tâm sẽ giúp chúng tôi tìm '
                            'kiếm tài liệu phù hợp cho bạn',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: context.read<UpdateBioCubit>(),
                                child: const UpdateHobbiesView(),
                              )),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  _buildHobbies(UpdateBioState state, BuildContext context) {
    List<Widget> chips = List();
    state.hobbies.value.forEach((element) {
      chips.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: Chip(
            deleteIconColor: Colors.white,
            onDeleted: () {
              List<String> temp = [];
              state.hobbies.value.forEach((element) {
                temp.add(element);
              });
              temp.remove(element);
              context.read<UpdateBioCubit>().hobbiesChanged(temp);
            },
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.lightBlueAccent,
            label: Text(
              element,
            ),
          ),
        ),
      );
    });

    return Wrap(
      children: chips,
    );
  }
}
