import 'package:cloud_firestore/cloud_firestore.dart';

class GetPriceHistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getItemPriceHistory(String itemName) async {
    try {
      final snapshot = await _firestore
          .collection('items')
          .where('Name', isEqualTo: itemName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        return data['priceHistory'] as Map<String, dynamic>?;
      }
      return null;
    } catch (e) {
      print('Error fetching price data: $e');
      rethrow;
    }
  }
}
