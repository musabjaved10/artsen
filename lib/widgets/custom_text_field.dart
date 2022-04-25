import 'package:artsen_van/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? suffixText;
  bool hasIcon;
  final Icon? prefixIcon;
  double margin;

  CustomTextField(
      {Key? key,
        required this.label,
        required this.controller,
        this.hasIcon = false,
        this.suffixText,
        this.prefixIcon,
        this.margin = 14.0})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: widget.margin),
      padding: EdgeInsets.only(right: 10),
      width: Get.width * 0.8,
      height: Get.height * 0.075,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), border: Border.all(color: COLOR_DARK_BLUE)),
      child: TextFormField(
        // initialValue: widget.controller.text,
        controller: widget.controller,
        obscureText: isObscure,
        style: TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon ?? Icon(null),
            suffixText: widget.suffixText,
            suffixStyle: TextStyle(fontSize: 12),
            labelText: widget.label,
            border: InputBorder.none,
            suffixIcon: widget.hasIcon
                ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: isObscure
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off))
                : null),
      ),
    );
  }
}