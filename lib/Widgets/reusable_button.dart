import 'package:flutter/material.dart';

import '../Core/colors.dart';
import '../Core/constants.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({super.key, required this.btnText, required this.onTapFunction});
  final String btnText;
  final Function onTapFunction;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:(){
      onTapFunction();
    } ,
      style: ElevatedButton.styleFrom(
      backgroundColor: kBasicColor,
      minimumSize:const Size.fromHeight(50), //MediaQuery.of(context).size*0.06,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBtnRadius),
      ),

    ),
      child: Text(
        btnText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),);
  }
}



