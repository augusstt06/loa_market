import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loa_market/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loa_market/utils/utils.dart';

Future<ResponseItemList> fetchItems(String item) async {
  final String apiUrl = dotenv.env['LOA_POST_ITEM_API_ENDPOINT'] ?? '';
  if (apiUrl == '') throw Exception('API URL is not set');
  final reqHeader = {
    'accept': 'application/json',
    'authorization': 'bearer ${dotenv.env['LOA_API_KEY']}',
  };

  final items = convertItemNickname(item);
  if (items.length == 1) {
    final response =
        await http.post(Uri.parse(apiUrl), headers: reqHeader, body: {
      "Sort": "GRADE",
      "CategoryCode": getItemCode(item),
      "ItemName": convertItemNickname(item)[0],
      "SortCondition": "ASC"
    });
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body)['Items'];
      final result = jsonResponse.map((item) => Item.fromJson(item)).toList();

      return result;
    }
  } else {
    final List<Future<ResponseItemList>> futureList = [];
    for (var item in items) {
      futureList.add(http.post(Uri.parse(apiUrl), headers: reqHeader, body: {
        "Sort": "GRADE",
        "CategoryCode": getItemCode(item),
        "ItemName": item,
        "SortCondition": "ASC"
      }).then((res) {
        if (res.statusCode == 200) {
          final List<dynamic> jsonResponse = json.decode(res.body)['Items'];
          final result =
              jsonResponse.map((item) => Item.fromJson(item)).toList();
          return result;
        } else {
          return [];
        }
      }));
    }
    final result = await Future.wait(futureList);
    return result.expand((x) => x).toList();
  }
  return [];
}
