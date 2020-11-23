import 'package:flutter/material.dart';
import 'package:share_ute/document_solution/document_solution.dart';

class DocumentSolutionPage extends StatelessWidget{

  const DocumentSolutionPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => const DocumentSolutionPage());
  }

  @override
  Widget build(BuildContext context) {
    return DocumentSolutionForm();
  }

}