import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmallButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const SmallButton({Key? key, required this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.cyan, Color(0xff13ffff)])
      ),
      width: Get.width * 0.125,
      height: Get.width * 0.125,
      child: IconButton(
        icon: Icon(icon, color: Colors.white,),
        onPressed: onPressed,
      ),
    );
  }
}
