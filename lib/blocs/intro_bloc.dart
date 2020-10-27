import 'dart:async';

import 'package:share_ute/repositories/intro_repository.dart';
import 'package:share_ute/views/intro_pages/first_view.dart';

class IntroBloc{
  StreamController _majorController = new StreamController();
  StreamController _subjectController = new StreamController();

  List<String> _major = new List<String>();
  List<String> _subject = new List<String>();

  IntroRepository _repository = new IntroRepository();

  Stream get majorStream => _majorController.stream;
  Stream get subjectStream => _subjectController.stream;

  List<String> get getMajor => _major;
  List<String> get getSubject => _subject;


  void loadDataMajor(TYPE_TRAINING type){
    _major = _repository.getMajors();
    _majorController.sink.add(true);
  }

  void loadDataSubject(idMajor){
    _subject = _repository.getSubject();
    _subjectController.sink.add(true);
  }

  void dispose(){
    _majorController.close();
    _subjectController.close();
  }
}