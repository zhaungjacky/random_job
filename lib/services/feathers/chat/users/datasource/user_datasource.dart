import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_job/services/services.dart';

abstract interface class UserDatasource {
  Stream<List<Map<String, dynamic>>> getUsersStream();
}

class UserDatasourceImpl implements UserDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String mainCollection() => "users";

  @override
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    try {
      return _firestore.collection(mainCollection()).snapshots().map(
        (snapshot) {
          return snapshot.docs.map(
            (doc) {
              final user = doc.data();
              return user;
            },
          ).toList();
        },
      );
    } on FirebaseException catch (err) {
      throw MyException(err.code);
    }
  }
}
