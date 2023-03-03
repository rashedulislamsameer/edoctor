

import 'package:e_doctor_last/models/user.dart';
import 'package:e_doctor_last/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user object based on firebase user

  Userid _userFromFirebaseUser(User user){
    return user != null ? Userid(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<Userid> get user{
    return _auth.authStateChanges()
          .map(_userFromFirebaseUser);
    
  }


  // sign in annon

  Future signInAnon() async{
    try {
     UserCredential result = await _auth.signInAnonymously();
     User user = result.user;
     return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }
//registar with email and password

 Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('include your blood group','new user change your profile name', 'previous cases');
      
      
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }



  //sign out
  Future signOut()async{
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}