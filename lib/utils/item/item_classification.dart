import '../../constant/constant.dart';

String getItemCode(String itemName) {
  if (itemClassification(itemName) == REINFORCE) {
    return reinforceCode;
  }
  return engraveCode;
}

String itemClassification(String itemName) {
  if (itemKeyword.any((item) => itemName.contains(item))) {
    return REINFORCE;
  }
  return ENGRAVE;
}

List<String> convertItemNickname(String itemName) {
  switch (itemName) {
    case '명파':
      return ['명예의 파편', '운명의 파편'];
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
    case '저받':
      return ['저주받은 인형'];
    case '마흐':
      return ['마나의 흐름'];
    case '결대':
      return ['결투의 대가'];
    case '구동':
      return ['구슬동자'];
    case '급타':
      return ['급소 타격'];
    case '달저':
      return ['달인의 저력'];
    case '돌대':
      return ['돌격대장'];
    case '속속':
      return ['속전속결'];
    case '안상':
      return ['안정된 상태'];
    case '에포':
      return ['에테르 포식자'];
    case '예둔':
      return ['예리한 둔기'];
    case '위모':
      return ['위기 모면'];
    case '정흡':
      return ['정기 흡수'];
    case '정단':
      return ['정밀 단도'];
    case '질증':
      return ['질량 증가'];
    case '최마증':
      return ['최대 마나 증가'];
    case '타대':
      return ['타격의 대가'];
    case '폭전':
      return ['폭발물 전문가'];
    default:
      return [itemName];
  }
}
