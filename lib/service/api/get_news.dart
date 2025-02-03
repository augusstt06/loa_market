import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchNews() async {
  final String apiUrl = dotenv.env['LOA_GET_NEWS_API_ENDPOINT'] ?? '';
  if (apiUrl == '') throw Exception('API URL is not set');

  final response = await http.get(Uri.parse(apiUrl), headers: {
    'accept': 'application/json',
    'authorization': 'bearer ${dotenv.env['LOA_API_KEY']}',
  });

  if (response.statusCode == 200) {
    final List<dynamic> newsList = json.decode(response.body);
    // 최근 5개만 리턴할 경우 아래 코드 주석 해제
    // return newsList.take(5).toList();
    return newsList;
  } else {
    throw Exception('Failed to load news');
  }
}
