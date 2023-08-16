import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:groups/helper/helper_function.dart';
import 'package:groups/pages/home_page.dart';
import 'package:groups/pages/login_page.dart';
import 'package:groups/service/auth_service.dart';
import 'package:groups/widgets/widgets.dart';
import 'package:lottie/lottie.dart';
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  String fullName = "";
  String email ="";
  String password = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator(color: Colors.cyan,),) : SingleChildScrollView(
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
                Text("Create your account now to chat and explore",style: TextStyle(
                    fontSize: 15,fontWeight:FontWeight.w400
                ),),
                Center(
                  child: Lottie.asset("assets/registration.json"),

                ),
                SizedBox(height: 45,),
                TextFormField(
                  decoration:textInputDecoration.copyWith(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person,color: Colors.cyan,)
                  ),
                  onChanged: (val){
                    setState(() {
                      fullName = val;
                      print(fullName);
                    });
                  },
                  validator: (val){
                    if(val!.isNotEmpty){
                      return null;
                    }
                    else{
                      return "Name cannot be empty";
                    }
                  },
                ),
                SizedBox(height: 15,),
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
                      register();
                    },
                    child: Text("Register",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 25,),
                Text.rich(
                    TextSpan(
                      text: "Already have an account!  ",

                      style: TextStyle(
                          color: Colors.black,fontSize: 18
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Login now", style: TextStyle(
                            color: Colors.cyan,fontSize: 20
                        ),
                            recognizer: TapGestureRecognizer()..onTap=(){
                              Get.to(LoginPage());
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
  void register() async{
    if(_formkey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService.registerUserWithEmailandPassword(fullName, email, password).then((value)async{
        if(value == true){
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserEmailSF(email);
          await HelperFunction.saveUserNameSF(fullName);
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

