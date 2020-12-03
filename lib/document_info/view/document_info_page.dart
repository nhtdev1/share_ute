import 'package:flutter/material.dart';
import 'package:share_ute/document_info/document_info.dart';

class DocumentInfoPage extends StatelessWidget {
  const DocumentInfoPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (context) => const DocumentInfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return DocumentInfoForm();
  }
}
