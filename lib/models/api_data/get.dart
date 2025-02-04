// 로아 개발 공홈 api
// GET News 응답 모델

typedef TGetNewsResponse = List<GetNewsItem>;

class GetNewsItem {
  final String title;
  final String date;
  final String link;
  final String type;

  GetNewsItem({
    required this.title,
    required this.date,
    required this.link,
    required this.type,
  });

  // JSON을 GetNewsItem 객체로 변환하기 위한 factory 메서드
  factory GetNewsItem.fromJson(Map<String, dynamic> json) {
    return GetNewsItem(
      title: json['Title'],
      date: json['Date'],
      link: json['Link'],
      type: json['Type'],
    );
  }
}

// External API
// GET crystal 응답 모델
class GetCrystalResponse {
  final String buy;
  final String sell;
  final String date;
  final String result;

  GetCrystalResponse({
    required this.buy,
    required this.sell,
    required this.date,
    required this.result,
  });
  factory GetCrystalResponse.fromJson(Map<String, dynamic> json) {
    return GetCrystalResponse(
      buy: json['Buy'],
      sell: json['Sell'],
      date: json['Date'],
      result: json['Result'],
    );
  }
}
