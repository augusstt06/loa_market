import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.title,
      required this.fontSize,
      this.isBold = false,
      this.isWhite = true});
  final String title;
  final double fontSize;
  final bool isBold;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        color: isWhite ? Colors.white : Colors.black,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
