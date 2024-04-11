import 'package:flutter/material.dart';

class ReusableChipTab extends StatelessWidget {
  const ReusableChipTab({super.key, required this.text, required this.onPressFunc, required this.color});
final String text;
final Function onPressFunc;
final Color? color;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
       onPressFunc();
      },
      child: Chip(
        label: Text(text),
        backgroundColor: color,

      ),
    );
  }
}
