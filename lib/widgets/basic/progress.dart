import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  const Progress({super.key, this.isWhite = false});
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          isWhite ? Colors.white : Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
