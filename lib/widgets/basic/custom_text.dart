import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.title, required this.fontSize});
  final String title;
  final String fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: fontSize == 'large'
          ? Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              )
          : fontSize == 'medium'
              ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  )
              : Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                  ),
    );
  }
}
