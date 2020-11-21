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
          previous.post.postYear != current.post.postYear,
      builder: (context, state) {
        List<Widget> tiles = List();
        data.forEach((element) {
          tiles.add(
            Material(
              color: Colors.white,
              elevation: 14.0,
              shadowColor: Color(0x802196F3),
              borderRadius: BorderRadius.circular(10.0),
              child: GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: state.post.postYear == element
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
                              fontWeight: state.post.postYear == element
                                  ? FontWeight.bold
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (state.post.postYear == element)
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
                  if (state.post.postYear != element) {
                    context
                        .read<UploadPostCubit>()
                        .yearChanged(element);
                  } else {
                    context.read<UploadPostCubit>().yearChanged('');
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
                color: Colors.black54,
              ),
              backgroundColor: Colors.lightBlue,
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
