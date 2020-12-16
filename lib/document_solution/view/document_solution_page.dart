import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/document_solution/document_solution.dart';
import 'package:share_ute/solution_notification/solution_notification.dart';
import 'package:share_ute/upload_solution/upload_solution.dart';
import 'package:solution_repository/solution_repository.dart';

class DocumentSolutionPage extends StatelessWidget {
  const DocumentSolutionPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (context) => const DocumentSolutionPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DocumentSolutionBloc(
        solutionRepository: SolutionRepository(),
        solutionNotificationCubit: context.read<SolutionNotificationCubit>(),
      )..add(DocumentSolutionFetched()),
      child: Scaffold(
        body: DocumentSolutionForm(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 2.0,
          child: RadiantGradientMask(
            child: Icon(
              const IconData(
                0xf489,
                fontFamily: CupertinoIcons.iconFont,
                fontPackage: CupertinoIcons.iconFontPackage,
              ),
              size: 30.0,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              UploadSolutionPage.route(),
            );
          },
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 0.0),
        colors: [const Color(0xffee0000), const Color(0xffeeee00)],
        tileMode: TileMode.repeated,
      ).createShader(bounds),
      child: child,
    );
  }
}
