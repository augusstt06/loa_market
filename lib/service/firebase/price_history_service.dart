import 'package:cloud_firestore/cloud_firestore.dart';

class PriceHistoryService {
  static final PriceHistoryService _instance = PriceHistoryService._internal();
  factory PriceHistoryService() => _instance;
  PriceHistoryService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
}
