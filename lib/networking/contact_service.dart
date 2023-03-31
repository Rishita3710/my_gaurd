import 'package:firebase_database/firebase_database.dart';

class ContactService {
  Future<DataSnapshot> getEmergencyContacts(String uid) async {
    return await FirebaseDatabase.instance.ref("contacts/$uid").get();
  }

  Future<void> saveEmergencyContact(
    String uid,
    String emergencyContact,
    Map<String, dynamic> data,
  ) async {
    return await FirebaseDatabase.instance
        .ref("contacts/$uid/$emergencyContact")
        .set(data);
  }

  Future<void> deleteEmergencyContact(
    String uid,
    String emergencyContact,
  ) async {
    return await FirebaseDatabase.instance
        .ref("contacts/$uid/$emergencyContact")
        .set(null);
  }
}
