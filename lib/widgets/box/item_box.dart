import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/models/api_data/post.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';

// FIXME: 팝업으로 바꿀지 고민중
class ItemBox extends StatelessWidget {
  const ItemBox({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              item.icon,
              width: 60,
              height: 60,
            ),
            const Gap(10),
            CustomText(
              title: item.name,
              fontSize: 'medium',
              isBold: true,
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title: '${item.recentPrice}',
                  fontSize: 'medium',
                  isBold: true,
                ),
                const Gap(10),
                Image.asset(
                  'assets/images/골드.png',
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
