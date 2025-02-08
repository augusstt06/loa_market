import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loa_market/constant/constant.dart';
import 'package:loa_market/models/models.dart';

class PriceHistoryService {
  static final PriceHistoryService _instance = PriceHistoryService._internal();
  factory PriceHistoryService() => _instance;
  PriceHistoryService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> recordItemPrices(ResponseItemList responseItems) async {
    try {
      final batch = _db.batch();
      final collection = _db.collection('price_history');

      for (String trackedItem in trackedItemList) {
        final matchingItem = responseItems
            .where((item) => item.name.contains(trackedItem))
            .firstOrNull;

        if (matchingItem != null) {
          final doc = collection.doc();
          batch.set(doc, {
            'Id': matchingItem.id,
            'Name': matchingItem.name,
            'Grade': matchingItem.grade,
            'Icon': matchingItem.icon,
            'BundleCount': matchingItem.bundleCount,
            'TradeRemainCount': matchingItem.tradeRemainCount,
            'YDayAvgPrice': matchingItem.yDayAvgPrice,
            'RecentPrice': matchingItem.recentPrice,
            'CurrentMinPrice': matchingItem.currentMinPrice,
            'Timestamp': FieldValue.serverTimestamp(),
          });

          debugPrint('기록된 아이템: ${matchingItem.name}');
        }
      }

      await batch.commit();
      debugPrint('모든 아이템의 가격이 기록되었습니다.');
    } catch (e) {
      debugPrint('가격 기록 중 오류 발생: $e');
      rethrow;
    }
  }
}
