import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loa_market/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<PostItemResponse> fetchItems(String item) async {
  final String apiUrl = dotenv.env['LOA_POST_ITEMS_API_ENDPOINT'] ?? '';
  if (apiUrl == '') throw Exception('API URL is not set');

  // FIX: request 형식에 맞추어서 수정
  final response = await http.post(Uri.parse(apiUrl), headers: {
    'accept': 'application/json',
    'authorization': 'bearer ${dotenv.env['LOA_API_KEY']}',
  }, body: {
    'itemName': item,
    // FIX: categoryCode 정리하기
    'categoryCode': 1,
    'sort': 'GRADE',
    'pageNo': 0,
    'sortCondition': 'ASC',
  });

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    return PostItemResponse.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load items');
  }
}
