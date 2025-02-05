import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loa_market/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loa_market/utils/utils.dart';

Future<List<Item>> fetchItems(String item) async {
  final String apiUrl = dotenv.env['LOA_POST_ITEM_API_ENDPOINT'] ?? '';
  if (apiUrl == '') throw Exception('API URL is not set');

  final response = await http.post(Uri.parse(apiUrl), headers: {
    'accept': 'application/json',
    'authorization': 'bearer ${dotenv.env['LOA_API_KEY']}',
  }, body: {
    "Sort": "GRADE",
    "CategoryCode": getItemCode(item),
    "ItemName": convertItemNickname(item)[0],
    "SortCondition": "ASC"
  });

  if (response.statusCode == 200) {
    final List<dynamic> jsonResponse = json.decode(response.body)['Items'];
    print('Fetched Items Count: ${jsonResponse.length}'); // jsonResponse의 길이 출력

    final result = jsonResponse.map<Item>((jsonItem) {
      return Item(
        id: jsonItem['Id'],
        name: jsonItem['Name'],
        grade: jsonItem['Grade'],
        icon: jsonItem['Icon'],
        bundleCount: jsonItem['BundleCount'],
        tradeRemainCount: jsonItem['TradeRemainCount'],
        yDayAvgPrice: jsonItem['YDayAvgPrice'],
        recentPrice: jsonItem['RecentPrice'],
        currentMinPrice: jsonItem['CurrentMinPrice'],
      );
    }).toList();

    return result;
  } else {
    throw Exception('Failed to load items');
  }
}
