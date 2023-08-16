import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:groups/pages/chat_page.dart';

import '../pages/register_page.dart';

class GroupTile extends StatefulWidget {
  String userName;
  String groupId;
  String groupName;

  GroupTile(
      {Key? key,
      required this.groupName,
      required this.userName,
      required this.groupId})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(chatPage(groupName: widget.groupName, groupId:widget.groupId, userName: widget.userName,));

      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical:10,horizontal: 5 ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xFF00cc00),
            child: Text(widget.groupName.substring(0,1),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
          ),
          title: Text(widget.groupName,style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text("Join the conversation as ${widget.userName}",style: TextStyle(fontSize: 13),),
        ),
      ),
    );
  }
}
