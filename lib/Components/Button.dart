import 'package:flutter/material.dart';
import 'package:goprogs_internship_task/Utils/constants.dart';

class Button extends StatelessWidget {
  VoidCallback? onPressed;
  String title;
  Color color;
  Button({super.key, required this.onPressed, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(color: color),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
