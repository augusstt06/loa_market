// 로아 개발 공홈 api
// GET News 응답 모델
class GetNewsResponse {
  final String title;
  final String date;
  final String link;
  final String type;

  GetNewsResponse({
    required this.title,
    required this.date,
    required this.link,
    required this.type,
  });
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
}
