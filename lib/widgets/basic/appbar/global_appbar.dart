import 'package:flutter/material.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlobalAppBar({
    super.key,
    required this.toggleTheme,
  });

  final void Function() toggleTheme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(title: 'LOA Market', fontSize: 'large'),
      leading: IconButton(
        onPressed: toggleTheme,
        icon: Icon(
          Theme.of(context).brightness == Brightness.dark
              ? Icons.sunny
              : Icons.nightlight,
          color: Colors.amber,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
