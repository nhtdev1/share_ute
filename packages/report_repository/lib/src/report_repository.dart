import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_repository/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class ReportRepository {
  ReportRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Future<Report> createReport({Report report}) async {
    try {
      final result = await _firebaseFirestore.collection('reports').add({
        'uid': _firebaseAuth.currentUser.uid,
        'postId': report.postID,
        'problem': report.problem,
        'dateReported': report.dateReported,
      });
      return report.copyWith(
        id: result.id,
      );
    } on Exception {
      return Report.empty;
    }
  }
}
