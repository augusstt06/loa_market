class ItemApiRequest {
  static const String sort = 'GRADE';
  final int categoryCode;
  final String itemName;
  static const int pageNo = 0;
  static const String sortCondition = 'ASC';

  ItemApiRequest({
    required this.categoryCode,
    required this.itemName,
  });
}

class ItemApiResponse {
  final int pageNo;
  final int pageSize;
  final int totalCount;
  final List<Item> items;

  ItemApiResponse({
    required this.pageNo,
    required this.pageSize,
    required this.totalCount,
    required this.items,
  });
}

class Item {
  final int id;
  final String name;
  final String grade;
  final String icon;
  final int bundleCount;
  final int? tradeRemainCount;
  final int yDayAvgPrice;
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
}
