import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fproject/Database/databasek.dart';
import 'package:fproject/models/user.dart';

class Authservice extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user object based on FirebaseUser
  // UserM? _userFromFirebaseUser(User? user){
  //   if(user!=null){
  //     return UserM(uid: user.uid);
  //   }
  //   else{
  //     return null;
  //   }
  // }
  // auth change user stream
  // Stream<UserM?> get user{
  //   return _auth.authStateChanges().map(_userFromFirebaseUser);
  // }

  // sign in email password
  // auth change user stream
  Stream<personalUser?> get user{
    return _auth.authStateChanges().map(_userfromfirebase);
  }
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromfirebase(user);
    }
    catch(e){
      print(e);
      return null;
    }
  }

  // register with email password
  Future registerWithEmailAndPassword(String email, String password, String fname, String lname) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await DatabaseService(uid: user!.uid).updateUserData(fname, lname);
      return _userfromfirebase(user);
    }
    catch(e){
      print(e);
      return null;
    }
  }
  // Add Product
  // sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }

}
// create our own user from firebase user
personalUser? _userfromfirebase(User? user) {
  if(user !=null){
    return personalUser(uid: user.uid);
  }
  else{
    return null;}
}