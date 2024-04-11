import 'package:flutter/material.dart';
import 'package:golden_test/Core/colors.dart';

class ReusableChipSubCategory extends StatelessWidget {
  const ReusableChipSubCategory(
      {super.key, required this.text, required this.onPressFunc});
  final String text;
  final Function onPressFunc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: 36,
            padding: const EdgeInsets.only(left: 5,top: 6),
            child: Chip(
              label: Text(text,textAlign:TextAlign.center,style:TextStyle(color:Colors.white)),
              backgroundColor: kBasicColor,
            ),
          ),
            Positioned(
              child: CircleAvatar(
                backgroundColor: kBasicColor,
                radius: 9,
                child: InkWell(onTap: (){
                  onPressFunc();
                }, child: const Icon(
                  Icons.close,
                  size: 13,
                  color: Colors.white,
                )),
              ))
        ],
      ),
    );
  }
}
