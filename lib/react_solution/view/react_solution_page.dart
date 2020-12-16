import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/react_solution/react_solution.dart';
import 'package:solution_repository/solution_repository.dart';

class ReactSolutionPage extends StatelessWidget {
  const ReactSolutionPage({Key key, @required this.solution}) : super(key: key);

  final Solution solution;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReactSolutionBloc>(
      create: (context) => ReactSolutionBloc(
        solutionRepository: context.read<SolutionRepository>(),
        authenticationBloc: context.read<AuthenticationBloc>(),
        solution: solution,
      ),
      child: ReactSolutionForm(),
    );
  }
}
