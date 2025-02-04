import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/models/api_data/get.dart';

import 'package:loa_market/service/api/get_crystal.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';
import 'package:loa_market/widgets/basic/progress.dart';

class CrystalBox extends StatefulWidget {
  const CrystalBox({super.key});

  @override
  State<CrystalBox> createState() => _CrystalBoxState();
}

class _CrystalBoxState extends State<CrystalBox> {
  GetCrystalResponse? crystalInfo;
  bool isLoading = true;
  Timer? _rerun;

  @override
  void initState() {
    super.initState();
    fetchCrystalInfo();
    _reRunGetCrystalInfo();
  }

  Future<void> fetchCrystalInfo() async {
    try {
      final GetCrystalResponse crystalInfo = await fetchCrystal();
      setState(() {
        this.crystalInfo = crystalInfo;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _reRunGetCrystalInfo() {
    _rerun = Timer.periodic(Duration(hours: 1), (timer) {
      fetchCrystalInfo();
    });
  }

  // 위젯이 필요없어지면 타이머 해제
  @override
  void dispose() {
    _rerun?.cancel();
    super.dispose();
  }

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
          child: SizedBox(
            child: isLoading
                ? Progress()
                : Column(
                    children: [
                      CustomText(
                          title: '크리스탈 시세', fontSize: 'large', isBold: true),
                      const Gap(20),
                      if (crystalInfo != null)
                        buildPriceRow('판매가', crystalInfo?.sell ?? ''),
                      const Gap(10),
                      buildPriceRow('구매가', crystalInfo?.buy ?? ''),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildPriceRow(String title, dynamic price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomText(title: title, fontSize: 'large'),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              CustomText(title: '$price', fontSize: 'large'),
              const Gap(10),
              Image.asset(
                'assets/images/골드.png',
                width: 25,
                height: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
