import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/constant/constant.dart';
import 'package:loa_market/models/api_data/post.dart';
import 'package:loa_market/utils/utils.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';
import 'package:loa_market/widgets/dialog/item_graph_dialog.dart';

class ItemBox extends StatelessWidget {
  const ItemBox({super.key, required this.item});
  final Item item;

  bool get _showPriceHistoryButton {
    if (item.name.endsWith('각인서') && item.grade == '유물') {
      final engraveName = item.name.replaceAll('각인서', '').trim();
      return trackedEngraveItemList.contains(engraveName);
    } else if (item.name.contains('주머니')) {
      final reinforceName = item.name.split('주머니')[0].trim();
      return trackedReinforceItemList.contains(reinforceName);
    }
    return trackedReinforceItemList.contains(item.name);
  }

  bool get isEngraveItem {
    return item.name.endsWith('각인서');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 60,
                  child: Image.network(item.icon),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        title: isEngraveItem
                            ? '${item.grade} ${item.name.replaceAll('각인서', '').trim()}'
                            : item.name,
                        fontSize: 17,
                        isBold: true,
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            title: addComma(item.recentPrice),
                            fontSize: 20,
                            isBold: true,
                          ),
                          const Gap(10),
                          Image.asset(
                            'assets/images/골드.png',
                            width: 25,
                            height: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _showPriceHistoryButton
                  ? Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => ItemGraphDialog(
                              itemName: item.name,
                              currentPrice: item.recentPrice,
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: const SizedBox.shrink(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
