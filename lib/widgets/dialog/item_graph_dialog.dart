import 'package:flutter/material.dart';

import '../../service/service.dart';

class ItemGraphDialog extends StatefulWidget {
  const ItemGraphDialog({super.key, required this.itemName});
  final String itemName;

  @override
  State<ItemGraphDialog> createState() => _ItemGraphDialogState();
}

class _ItemGraphDialogState extends State<ItemGraphDialog> {
  final GetPriceHistoryService _itemService = GetPriceHistoryService();
  bool isLoading = true;
  Map<String, dynamic>? priceHistory;

  Future<void> _fetchItemPriceHistory() async {
    try {
      final data = await _itemService.getItemPriceHistory(widget.itemName);
      setState(() {
        priceHistory = data;
        isLoading = false;
      });
      print('priceHistory: $priceHistory');
    } catch (e) {
      print('Error fetching price history: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchItemPriceHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text('${widget.itemName} 가격 그래프'),
          ],
        ),
      ),
    );
  }
}
