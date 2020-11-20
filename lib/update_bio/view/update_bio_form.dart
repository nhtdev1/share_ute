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
          if (state.updateProgress == UpdateBioProgress.submissionSuccess) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  elevation: 10.0,
                  backgroundColor: Colors.blue,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Cập nhật thành công'),
                ),
              );
          } else if (state.updateProgress ==
              UpdateBioProgress.submissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  elevation: 10.0,
                  backgroundColor: Colors.blue,
                  behavior: SnackBarBehavior.floating,
                  content: Text('Cập nhật thất bại'),
                ),
              );
          }
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            _YearRow(),
            const Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
            _FacultyRow(),
            const Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
            _MajorRow(),
            const Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
            _HobbiesRow(),
            const Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
            _UpdateButton(),
          ],
        ));
  }
}

class _YearRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBioCubit, UpdateBioState>(
        buildWhen: (previous, current) =>
            previous.user.year != current.user.year,
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
                    state.user.year.isEmpty ? 'Không rõ' : state.user.year,
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
                      ),
                    ),
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
            previous.user.faculty != current.user.faculty,
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
                    state.user.faculty.isEmpty
                        ? 'Không rõ'
                        : state.user.faculty,
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
            previous.user.major != current.user.major,
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
                    state.user.major.isEmpty ? 'Không rõ' : state.user.major,
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
            previous.user.hobbies != current.user.hobbies,
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
                      if (!state.user.hobbies.isNotEmpty)
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
                        ),
                      ),
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
    state.user.hobbies.forEach((element) {
      chips.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: Chip(
            deleteIconColor: Colors.white,
            onDeleted: () {
              List<String> temp = [];
              state.user.hobbies.forEach((element) {
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

class _UpdateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBioCubit, UpdateBioState>(
        builder: (context, state) {
          if (state.updateProgress == UpdateBioProgress.submissionInProgress) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
          if (state.bioStatus != BioStatus.unknown &&
              state.bioStatus != BioStatus.unchanged) {
            return Center(
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
            );
          }
          return Container();
        });
  }
}
