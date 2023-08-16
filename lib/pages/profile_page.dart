import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:groups/AI%20chat/bard_ai.dart';
import 'package:groups/pages/login_page.dart';

import '../service/auth_service.dart';
import 'home_page.dart';

class Profilepage extends StatefulWidget {
  String userName;

  String email;

  Profilepage({Key? key, required this.userName, required this.email})
      : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: () {
                 // Get.to(BardAi(userName: '', email: '',));
                },
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40,vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey[700],

            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Full Name",style: TextStyle(fontSize: 17),),
                Text(widget.userName,style: TextStyle(fontSize: 17),),
              ],
            ),
            Divider(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email",style: TextStyle(fontSize: 17),),
                Text(widget.email,style: TextStyle(fontSize: 17),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
