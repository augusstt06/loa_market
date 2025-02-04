import '../../constant/constant.dart';

int getItemCode(String itemName) {
  if (itemClassification(itemName) == 'reinforce') {
    return reinforceCode;
  }
  return engraveCode;
}

String itemClassification(String itemName) {
  if (itemName.contains('오레하') &&
      itemName.contains('숨결') &&
      itemName.contains('가호') &&
      itemName.contains('은총') &&
      itemName.contains('축복') &&
      itemName.contains('파괴') &&
      itemName.contains('수호') &&
      itemName.contains('에스더') &&
      itemName.contains('기운')) {
    return 'reinforce';
  }
  return 'engrave';
}
