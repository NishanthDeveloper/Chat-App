import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groups/helper/helper_function.dart';
import 'package:groups/service/database_services.dart';
class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future loginWithEmailandPassword(String email ,String password) async{


    try{
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;
      if(user != null){


        return true;
      }
    }on FirebaseAuthException catch(e){
      // print(e);
      return e.message;
    }
  }


  Future registerUserWithEmailandPassword(String fullName,String email ,String password) async{


    try{
     User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;
      if(user != null){
await DatabaseService(uid: user.uid).savingUserData(fullName, email, password);

        return true;
      }
    }on FirebaseAuthException catch(e){
     // print(e);
      return e.message;
    }
  }
  Future signOut() async{
    try{
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailSF("");
      await HelperFunction.saveUserNameSF("");
      await firebaseAuth.signOut();
    }catch(e){
      return null;
    }
  }
}