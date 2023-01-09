import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //reference to the collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference groupCollection =
  FirebaseFirestore.instance.collection('groups');

  //update user data
  Future updateUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      'fullName': fullName,
      'email': email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  //Getting use data
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection
        .where('email', isEqualTo: email)
        .get();
    return snapshot;
  }

  //Get user group data
  Future getUserGroups() async{
    return await userCollection.doc(uid).snapshots();
  }
}
