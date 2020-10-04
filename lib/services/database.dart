// import 'package:brew_crew/models/brew.dart';
// import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hanan/UI/Teacher.dart';
//
class DatabaseService {

  final String uid;

  DatabaseService({ this.uid });


//   // collection reference
  final CollectionReference teachersCollection = Firestore.instance.collection(
      'teachers');

//
  Future<void> updateTeacherData(String name, String age, String email, String phone, String gender, String type, String birthday) async {
    return await teachersCollection.doc(uid).set({
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      "gender": gender,
      "type": type,
      "birthday": birthday,
    });
  }
// //
//   // brew list from snapshot
  List<Teacher> _brewListFromSnapshot(QuerySnapshot snapshot) {

    return snapshot.docs.map((doc)
    {
      //print(doc.data);
      return Teacher(
        name: doc.data()['name'] ?? '',
        birthday : doc.data()['strength'] ?? '',
        email: doc.data()['email'] ?? '',
        phone: doc.data()['phone'],

      );
    }).toList();
  }
//
//   // get brews stream
//   Stream<List<Brew>> get brews {
//     return brewCollection.snapshots()
//         .map(_brewListFromSnapshot);
}