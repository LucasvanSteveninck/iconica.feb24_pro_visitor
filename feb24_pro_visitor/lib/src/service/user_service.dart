import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> deleteUserCurrentLocation(String userUid) async {
    try {
      await databaseRef.collection('users').doc(userUid).update({
        'current-location': FieldValue.delete(),
      });
    } catch (e) {
      throw Exception('Failed to delete current location');
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
}
