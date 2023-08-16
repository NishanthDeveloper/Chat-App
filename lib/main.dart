import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:groups/helper/helper_function.dart';
import 'package:groups/pages/home_page.dart';
import 'package:groups/pages/login_page.dart';
import 'package:groups/pages/splash_screen.dart';
import 'package:groups/shared/constants.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey:Constants.apiKey, appId: Constants.appId, messagingSenderId:Constants.messagingSenderId, projectId: Constants.projectId));
  }
  else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }
  getUserLoggedInStatus() async{
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if(value != null){
        setState(() {
          _isSignedIn = value;
        });

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      //_isSignedIn ? HomeScreen() : LoginPage(),
    );
  }
}
