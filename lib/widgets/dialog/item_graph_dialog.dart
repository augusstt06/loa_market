import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loa_market/widgets/graph/bar_graph.dart';

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

  List<FlSpot> points = [];
  List<String> dates = [];

  Future<void> _fetchItemPriceHistory() async {
    try {
      final Map<String, dynamic>? data =
          await _itemService.getItemPriceHistory(widget.itemName);

      if (data != null) {
        dates = data.keys.toList()..sort();

        points = dates.asMap().entries.map((entry) {
          final index = entry.key.toDouble();
          final date = entry.value;
          final priceData = data[date] as Map<String, dynamic>;
          final price = (priceData['YDayAvgPrice'] as num).toDouble();

          DateTime originalDate = DateTime.parse(date.replaceAll('.', '-'));
          DateTime yesterdayDate =
              originalDate.subtract(const Duration(days: 1));
          dates[entry.key] =
              '${yesterdayDate.year}.${yesterdayDate.month.toString().padLeft(2, '0')}.${yesterdayDate.day.toString().padLeft(2, '0')}';

          return FlSpot(index, price);
        }).toList();

        setState(() {
          isLoading = false;
        });
      }

      setState(() {
        priceHistory = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching price history: $e');
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
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text(
                    '${widget.itemName} 시세 그래프',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (points.isNotEmpty)
                    Expanded(
                      child: BarGraph(
                        graphPoints: points,
                        dates: dates,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
