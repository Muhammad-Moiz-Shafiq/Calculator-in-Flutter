import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  Mybutton(
      {required this.buttonColor,
      required this.buttonText,
      required this.textColor,
      required this.onPressed});
  late final String buttonText;
  late final Color buttonColor;
  late final Color textColor;
  late final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: buttonColor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
