import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/models/api_data/post.dart';
import 'package:loa_market/utils/utils.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';

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
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 60,
                child: Image.network(item.icon),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                          title: addComma(item.recentPrice),
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
                ), // 원하는 높이로 설정
              ),
              // 빈 공간을 추가하지 않음
            ],
          ),
        ),
      ),
    );
  }
}
