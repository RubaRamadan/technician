import 'package:flutter/material.dart';

import '../Core/colors.dart';
import '../Core/constants.dart';



class ReusableTextField extends StatefulWidget {
  const ReusableTextField({
    super.key,
    required this.onChangedFunc,
    required this.validationFunc,
    required this.hint,
    required this.isPasswordField,
    required this.textEditingController,
    required this.icon,
    this.isEnabled=true
  });
  final Function onChangedFunc;
  final Function validationFunc;
  final String hint;
  final bool isPasswordField;
  final TextEditingController textEditingController;
  final IconData icon;
  final bool isEnabled;
  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        enabled: widget.isEnabled,
        controller: widget.textEditingController,
        cursorColor: Colors.black,
        obscureText: widget.isPasswordField ? !showPassword : false,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(color: kIconsColor),
          prefixIcon:Icon(widget.icon, color: kIconsColor,)  ,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 25, 5),
          enabledBorder: const OutlineInputBorder(
            borderSide:
            BorderSide(color: kBorderColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(kRadius)),
          ),
          focusedBorder:   OutlineInputBorder(
            borderSide:
            BorderSide(color: kThirdColor, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(kRadius)),
          ),
          errorStyle: const TextStyle(
            fontSize: 10.0,
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(kRadius)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
        ),
        validator: (value) {
          return widget.validationFunc(value);
        },
        onChanged: (value) => widget.onChangedFunc(value),
      ),
    );
  }
}