import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/update_bio/update_bio.dart';

class UpdateFacultyView extends StatelessWidget {
  final List<String> data = const [
    'Hệ chất lượng cao',
    'Hệ đại trà',
  ];

  const UpdateFacultyView({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UpdateFacultyView());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBioCubit, UpdateBioState>(
      buildWhen: (previous, current) =>
          previous.faculty.value != current.faculty.value,
      builder: (context, state) {
        List<Widget> tiles = List();
        data.forEach((element) {
          tiles.add(
            Material(
              color: Colors.white,
              elevation: 14.0,
              shadowColor: Color(0x802196F3),
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: state.faculty.value == element
                            ? Border.all(
                          color: Colors.lightGreenAccent,
                        )
                            : null,
                      ),
                      child: GridTile(
                        child: Center(
                          child: Text(
                            element,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (state.faculty.value == element)
                      Positioned(
                        top: 5.0,
                        right: 5.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                      )
                  ],
                ),
                onTap: () {
                  if (state.faculty.value != element) {
                    context.read<UpdateBioCubit>().facultyChanged(element);
                  } else {
                    context.read<UpdateBioCubit>().facultyChanged('');
                  }
                },
              ),
            ),
          );
        });
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.grey,
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Color(0x802196F3),
              elevation: 0.0,
            ),
            body: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 1,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              children: tiles,
            ),
          ),
        );
      },
    );
  }
}
