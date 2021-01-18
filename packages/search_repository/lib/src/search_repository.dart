import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:search_repository/src/models/models.dart';

class SearchRepository {
  SearchRepository({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  Stream<PopularTags> get popularTags {
    return _firebaseFirestore
        .collection('tags')
        .doc('popular')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return PopularTags(
          tags: List<String>.from(snapshot['tags']),
        );
      }
      return PopularTags.empty;
    });
  }

  Stream<FeatureTags> get featureTags {
    return _firebaseFirestore
        .collection('tags')
        .doc('feature')
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return FeatureTags(
          tags: List<String>.from(snapshot['tags']),
        );
      }
      return FeatureTags.empty;
    });
  }
}
