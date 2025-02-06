import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.title,
      required this.fontSize,
      this.isBold = false,
      this.color = 'white'});
  final String title;
  final String fontSize;
  final bool isBold;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: fontSize == 'large'
          ? Theme.of(context).textTheme.titleLarge?.copyWith(
                color: color == 'white' ? Colors.white : Colors.black,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              )
          : fontSize == 'medium'
              ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color == 'white' ? Colors.white : Colors.black,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  )
              : Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: color == 'white' ? Colors.white : Colors.black,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  ),
    );
  }
}
