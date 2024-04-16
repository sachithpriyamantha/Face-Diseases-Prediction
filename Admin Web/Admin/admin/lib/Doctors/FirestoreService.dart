/*import 'package:admin/Doctors/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(User user) async {
    await firestore.collection('users').add(user.toMap());
  }

  Stream<List<User>> getUsers() {
    return firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Future<void> updateUser(User user) async {
    await firestore.collection('users').doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String userId) async {
    await firestore.collection('users').doc(userId).delete();
  }
}*/
