import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final userServiceInstance = UserService._();
  final FirebaseFirestore databaseRef = FirebaseFirestore.instance;

  UserService._();

  factory UserService() {
    return userServiceInstance;
  }

  Future<Map<String, dynamic>> getUser(String userUid) async {
    DocumentSnapshot response =
        await databaseRef.collection('users').doc(userUid).get();
    Object? result = response.data();
    if (result == null) throw Exception();
    return result as Map<String, dynamic>;
  }
}
