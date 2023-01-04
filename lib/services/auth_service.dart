import 'package:chatapp_flutter/helper/helper_function.dart';
import 'package:chatapp_flutter/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login with email and password

  //register with email and password
  Future registerWithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user!;

      if(user != null){
       await DatabaseService(
          uid: user.uid,
        ).updateUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //sign out

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserName("");
      await HelperFunctions.saveUserEmail("");
      await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
