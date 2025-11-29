import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  String buttonName;
  VoidCallback onPressed;
   MyButton({super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.yellow,
      onPressed: onPressed, child: Text(buttonName),);
  }
}