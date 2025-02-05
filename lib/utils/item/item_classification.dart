import '../../constant/constant.dart';

// 우선 러프하게 이런 기능이다~정도만 구현 -> 수정예정
String getItemCode(String itemName) {
  if (itemClassification(itemName) == 'reinforce') {
    return reinforceCode;
  }
  return engraveCode;
}

String itemClassification(String itemName) {
  if (itemName.contains('오레하') ||
      itemName.contains('아비도스') ||
      itemName.contains('숨결') ||
      itemName.contains('가호') ||
      itemName.contains('은총') ||
      itemName.contains('축복') ||
      itemName.contains('파괴') ||
      itemName.contains('수호') ||
      itemName.contains('에스더') ||
      itemName.contains('기운')) {
    return 'reinforce';
  }
  return 'engrave';
}

// 아이템 별명
List<String> convertItemNickname(String itemName) {
  switch (itemName) {
    case '명파':
      return ['명예의 파편'];
    case '운파':
      return ['운명의 파편'];
    case '숨결':
      return ['숨결', '가호', '은총', '축복'];
    case '오레하':
      return ['오레하', '아비도스'];
    case '경명돌':
      return ['경이로운 명예의 돌파석'];
    case '찬명돌':
      return ['찬란한 명예의 돌파석'];
    default:
      return [itemName];
  }
}
