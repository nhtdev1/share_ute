import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/update_bio/update_bio.dart';

class UpdateYearView extends StatelessWidget {
  final List<String> data = const [
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
  ];

  const UpdateYearView({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UpdateYearView());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateBioCubit, UpdateBioState>(
      buildWhen: (previous, current) =>
          previous.year.value != current.year.value,
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
                        border: state.year.value == element
                            ? Border.all(
                                color: Colors.lightBlueAccent,
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: GridTile(
                        child: Center(
                          child: Text(
                            element,
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 16,
                              letterSpacing: 1.0,
                              height: 1.5,
                              fontWeight: state.year.value == element
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (state.year.value == element)
                      Positioned(
                        top: 5.0,
                        right: 5.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (state.year.value != element) {
                    context.read<UpdateBioCubit>().yearChanged(element);
                  } else {
                    context.read<UpdateBioCubit>().yearChanged('');
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
              childAspectRatio: (MediaQuery.of(context).size.width / 2) /
                  ((MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height) /
                      4),
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
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
