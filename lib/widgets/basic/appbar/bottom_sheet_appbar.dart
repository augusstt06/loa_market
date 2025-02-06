import 'package:flutter/material.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';

class BottomSheetAppbar extends StatelessWidget {
  const BottomSheetAppbar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      title: CustomText(
        title: title,
        fontSize: 'large',
        isBold: true,
      ),
      centerTitle: true,
    );
  }
}
