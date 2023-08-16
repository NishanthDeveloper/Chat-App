import 'package:flutter/material.dart';

const  textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green,width: 2)
  ),
   enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.cyan,width: 2)
    ),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red,width: 2)
    )
);
void showSnackbar(context ,message,color){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message,style:const TextStyle(fontSize: 14),),backgroundColor:color,duration: const Duration(seconds: 2),action: SnackBarAction(label: "Ok",onPressed: (){},textColor: Colors.white,),));
}