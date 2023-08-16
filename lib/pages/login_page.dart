import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groups/helper/helper_function.dart';
import 'package:groups/pages/home_page.dart';
import 'package:groups/pages/register_page.dart';
import 'package:groups/service/auth_service.dart';
import 'package:groups/service/database_services.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import '../widgets/widgets.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  String email ="";
  String password = "";
  AuthService authService = AuthService();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:_isLoading ? Center(child: CircularProgressIndicator(color: Colors.cyan,),) : SingleChildScrollView(
  child:   Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
    child:   Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget> [
          Text("Groups",style: TextStyle(
            fontSize: 40,fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10,),
          Text("Login now to see what they are talking",style: TextStyle(
              fontSize: 15,fontWeight:FontWeight.w400
          ),),
          Center(
            child: Lottie.asset("assets/login.json"),
            
          ),
          SizedBox(height: 45,),
          TextFormField(
            decoration:textInputDecoration.copyWith(
              labelText: "Email",
              prefixIcon: Icon(Icons.email,color: Colors.cyan,)
            ),
            onChanged: (val){
              setState(() {
                email = val;
                print(email);
              });
            },
            validator: (value){
              return RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(value!) ? null : "Please enter the valid email";
            },
          ),
          SizedBox(height: 15,),
          TextFormField(
            obscureText: true,
            decoration:textInputDecoration.copyWith(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock,color: Colors.cyan,)
            ),
            validator: (val){
              if(val!.length < 6){
                return "Password must be at least 6 characters ";
              }
              else{
                return null;
              }
            },
            onChanged: (val){
              setState(() {
                password = val;
                print(password);
              });
            },
          ),
          SizedBox(height: 20,),
          Container(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: (){
                login();
              },
              child: Text("Sign In",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(height: 25,),
          Text.rich(
            TextSpan(
              text: "Don't have an account?  ",

                style: TextStyle(
              color: Colors.black,fontSize: 18
            ),
              children: <TextSpan>[
                TextSpan(
                  text: "Register here", style: TextStyle(
                    color: Colors.cyan,fontSize: 20
                ),
                  recognizer: TapGestureRecognizer()..onTap=(){
                    Get.to(RegistrationPage());

                  }
                )
              ],
            )
          )
        ],
      ),
    ),
  ),
),
    );
  }

  void login() async{
    if(_formkey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService.loginWithEmailandPassword( email, password).then((value)async{
        if(value == true){
     QuerySnapshot snapshot =     await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);
     await HelperFunction.saveUserLoggedInStatus(true);
     await HelperFunction.saveUserEmailSF(email);
     await HelperFunction.saveUserNameSF(snapshot.docs[0]['fullName']);
          Get.to(HomeScreen());

        }else{
          showSnackbar(context, value, Colors.red);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

}
