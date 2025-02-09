import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';

class AnnounceBox extends StatelessWidget {
  const AnnounceBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  title: '📌 개발 공지 📌',
                  fontSize: 25,
                  isBold: true,
                ),
              ),
              const Gap(15),
              CustomText(
                title: '1. 별칭으로도 아이템 검색이 가능합니다.',
                fontSize: 20,
              ),
              CustomText(
                title: 'e.g. 숨결 검색 => 용암/빙하의 숨결,태양의 가호/축복/은총 리스트업.',
                fontSize: 17,
              ),
              const Gap(10),
              CustomText(
                title: '2. 현재 시세 그래프는 수요가 많은 아이템에 한해 제공됩니다. ',
                fontSize: 20,
              ),
              CustomText(
                title: 'e.g. 유각, 강화재료',
                fontSize: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
