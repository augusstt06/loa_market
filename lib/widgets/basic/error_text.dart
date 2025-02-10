import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';
import 'package:loa_market/widgets/basic/progress.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.isError,
    required this.isWhite,
    required this.isProgressWhite,
  });
  final bool isError;
  final bool isWhite;
  final bool isProgressWhite;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Progress(isWhite: isProgressWhite),
        const Gap(25),
        isError
            ? CustomText(
                title: '에러가 발생했습니다.',
                fontSize: 18,
                isBold: true,
                isWhite: isWhite,
              )
            : const SizedBox(),
        const Gap(5),
        CustomText(
          title: isError ? '다시 시도해주세요.' : '데이터를 가져오는 중입니다.',
          fontSize: 18,
          isBold: true,
          isWhite: isWhite,
        ),
      ],
    );
  }
}
