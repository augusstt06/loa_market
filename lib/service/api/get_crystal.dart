import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchCrystal() async {
  final String apiUrl = dotenv.env['LOA_GET_CRYSTAL_API_ENDPOINT'] ?? '';
  if (apiUrl == '') throw Exception('API URL is not set');

  final response = await http.get(Uri.parse(apiUrl));
  final Map<String, dynamic> crystalInfo = json.decode(response.body);
  if (crystalInfo['Result'] == "Success") {
    return crystalInfo;
  } else {
    throw Exception('Failed to load crystal');
  }
}
