import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upload_post/upload_post.dart';

class UploadYearView extends StatelessWidget {
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

  const UploadYearView({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UploadYearView());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostCubit, UploadPostState>(
      buildWhen: (previous, current) =>
          previous.optional.year != current.optional.year,
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
                        border: state.optional.year.value == element
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
                    if (state.optional.year.value == element)
                      Positioned(
                        top: 5.0,
                        right: 5.0,
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (state.optional.year.value != element) {
                    context
                        .read<UploadPostCubit>()
                        .optionalYearChanged(element);
                  } else {
                    context.read<UploadPostCubit>().optionalYearChanged('');
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
              crossAxisCount: 2,
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