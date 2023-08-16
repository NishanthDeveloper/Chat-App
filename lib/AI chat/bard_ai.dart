import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:groups/pages/home_page.dart';
import 'package:groups/pages/login_page.dart';
import 'package:groups/service/auth_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BardAi extends StatefulWidget {
  String userName;

  String email;
  BardAi({Key? key, required this.userName, required this.email})
      : super(key: key);

  @override
  State<BardAi> createState() => _BardAiState();
}

class _BardAiState extends State<BardAi> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),

      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50),
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.grey[700],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.userName,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                height: 2,
              ),
              ListTile(
                onTap: () {
                  Get.to(HomeScreen());
                },
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.group),
                title: Text(
                  "Groups",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Divider(
                height: 2,
              ),
              ListTile(
                onTap: () {},
                selected: true,
                selectedColor: Colors.cyan,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.person),
                title: Text(
                  "Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Divider(
                height: 2,
              ),
              ListTile(
                onTap: () {},
                selectedColor: Colors.cyan,
                selected: true,
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.dialpad),
                title: Text(
                  "Bard Ai",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Divider(
                height: 2,
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Logout"),
                          content: Text("Are you sure you want to logout?"),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Get.to(HomeScreen());
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () async {
                                  authService.signOut().whenComplete(() {
                                    Get.to(LoginPage());
                                  });
                                },
                                icon: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ))
                          ],
                        );
                      });
                },
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: Icon(Icons.exit_to_app),
                title: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),

      ),
    //  body:WebView(
       // initialUrl: 'https://flutter.io',

    //  ),

    );
  }
}
