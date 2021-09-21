import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wms_app/models/user.dart';

class AuthService{

  final FirebaseAuth auth = FirebaseAuth.instance;

  //create user object
  FUser? userFromFirebase(user){
    return user != null ? FUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream <FUser?> get userState{
    return auth.authStateChanges().map(userFromFirebase);
  }

  //sign in anon
  Future signInAnon() async{
    try{
      var result = await auth.signInAnonymously();
      var user = result.user;
      return userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
    }
  }

  //sign in using email and password
  Future signInWithEmailAndPassword(String email, String pwd) async {
    try{
      var result = await auth.signInWithEmailAndPassword(email: email, password: pwd);
      var user = result.user;
      return userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
    }
  }
  //register using email and password
  Future registerWithEmailAndPassword(String email, String pwd) async {
    try{
      var result = await auth.createUserWithEmailAndPassword(email: email, password: pwd);
      var user = result.user;
      return userFromFirebase(user);
    }
    catch(e){
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async{
    try{
      await auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }
}


