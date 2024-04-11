import 'package:flutter/material.dart';

class ReusableSnackBar{
  void showSnackBarMessage({required bool isErrorSnackBar,required String message,required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: isErrorSnackBar? Colors.red:Colors.blueGrey,
    ));
  }
}