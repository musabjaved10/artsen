import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final VoidCallback? onPressed;
  double margin;

   CustomButton({
    Key? key,
    required this.text,
    this.height = 50,
    this.width = 150,
    this.onPressed,
    this.margin = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.cyan, Color(0xff21e3e3)])),
      child: TextButton(
          onPressed: onPressed,
          child: Text(text, style: themeData.textTheme.button)),
    );
  }
}