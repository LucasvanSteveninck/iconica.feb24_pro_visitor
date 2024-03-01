import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  static final locationServiceInstance = LocationService._();
  final FirebaseFirestore databaseRef = FirebaseFirestore.instance;

  LocationService._();

  factory LocationService() {
    return locationServiceInstance;
  }

  Future<Map<String, dynamic>> getLocation(String locationUid) async {
    DocumentSnapshot response =
        await databaseRef.collection('locations').doc(locationUid).get();
    Object? result = response.data();
    if (result == null) throw Exception();
    return result as Map<String, dynamic>;
  }

}
