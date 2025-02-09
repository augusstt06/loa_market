import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loa_market/constant/constant.dart';
import 'package:loa_market/models/models.dart';

class PriceHistoryService {
  static final PriceHistoryService _instance = PriceHistoryService._internal();
  factory PriceHistoryService() => _instance;
  PriceHistoryService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> _recordItemsByCategory(
    ResponseItemList items,
    List<String> trackedItems,
    WriteBatch batch,
    CollectionReference collection,
  ) async {
    for (String trackedItem in trackedItems) {
      final matchingItem =
          items.where((item) => item.name.contains(trackedItem)).firstOrNull;

      if (matchingItem != null) {
        final doc = collection.doc();
        batch.set(doc, {
          'Id': matchingItem.id,
          'Name': matchingItem.name,
          'Grade': matchingItem.grade,
          'YDayAvgPrice': matchingItem.yDayAvgPrice,
          'RecentPrice': matchingItem.recentPrice,
          'CurrentMinPrice': matchingItem.currentMinPrice,
          'Timestamp': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  Future<void> recordItemPrices(ResponseItemList responseItems) async {
    try {
      final batch = _db.batch();
      final collection = _db.collection('price_history');

      await _recordItemsByCategory(
          responseItems, trackedReinforceItemList, batch, collection);

      await _recordItemsByCategory(
          responseItems, trackedEngraveItemList, batch, collection);

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
