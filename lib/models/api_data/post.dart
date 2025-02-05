// 로아 개발 공홈 api
// POST item 요청/응답 모델
class PostItemRequest {
  static const String sort = 'GRADE';
  final int categoryCode;
  final String itemName;
  static const int pageNo = 0;
  static const String sortCondition = 'ASC';

  PostItemRequest({
    required this.categoryCode,
    required this.itemName,
  });
}

class PostItemResponse {
  final List<Item> items;

  PostItemResponse({
    required this.items,
  });

  factory PostItemResponse.fromJson(Map<String, dynamic> json) {
    return PostItemResponse(
      items: (json['Items'] as List<dynamic>)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }
}

class Item {
  final int id;
  final String name;
  final String grade;
  final String icon;
  final int bundleCount;
  final int? tradeRemainCount;
  final double yDayAvgPrice;
  final int recentPrice;
  final int currentMinPrice;

  Item({
    required this.id,
    required this.name,
    required this.grade,
    required this.icon,
    required this.bundleCount,
    this.tradeRemainCount,
    required this.yDayAvgPrice,
    required this.recentPrice,
    required this.currentMinPrice,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['Id'],
      name: json['Name'],
      grade: json['Grade'],
      icon: json['Icon'],
      bundleCount: json['BundleCount'],
      tradeRemainCount: json['TradeRemainCount'],
      yDayAvgPrice: json['YDayAvgPrice'],
      recentPrice: json['RecentPrice'],
      currentMinPrice: json['CurrentMinPrice'],
    );
  }
}
