import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loa_market/widgets/basic/error_text.dart';
import 'package:loa_market/widgets/graph/bar_graph.dart';
import 'dart:math' as math;
import '../../service/service.dart';

class ItemGraphDialog extends StatefulWidget {
  const ItemGraphDialog(
      {super.key, required this.itemName, required this.currentPrice});
  final String itemName;
  final int currentPrice;

  @override
  State<ItemGraphDialog> createState() => _ItemGraphDialogState();
}

class _ItemGraphDialogState extends State<ItemGraphDialog> {
  final GetPriceHistoryService _itemService = GetPriceHistoryService();
  bool isError = false;
  bool isLoading = true;
  bool isDaily = true;
  Map<String, dynamic>? priceHistory;

  List<FlSpot> dailyPoints = [];
  List<FlSpot> weeklyPoints = [];
  List<String> dailyDates = [];
  List<String> weeklyDates = [];

  void _calculateWeeklyData() {
    if (dailyPoints.isEmpty) return;

    weeklyPoints = [];
    weeklyDates = [];

    // 첫 번째 수요일
    int firstWedIndex = 0;
    while (firstWedIndex < dailyDates.length) {
      DateTime date =
          DateTime.parse(dailyDates[firstWedIndex].replaceAll('.', '-'));
      if (date.weekday == DateTime.wednesday) break;
      firstWedIndex++;
    }

    // 첫 번째 수요일 전의 데이터 처리 (있는 경우)
    if (firstWedIndex > 0) {
      List<FlSpot> firstWeekSpots = dailyPoints.sublist(0, firstWedIndex);
      double avgPrice =
          firstWeekSpots.map((spot) => spot.y).reduce((a, b) => a + b) /
              firstWeekSpots.length;
      weeklyPoints.add(FlSpot(weeklyPoints.length.toDouble(), avgPrice));
      weeklyDates.add('${dailyDates[0]}~\n${dailyDates[firstWedIndex - 1]}');
    }

    // 수요일부터 화요일까지 7일씩 묶어서 평균 계산
    for (int i = firstWedIndex; i < dailyPoints.length; i += 7) {
      int endIndex = math.min(i + 7, dailyPoints.length);
      List<FlSpot> weekSpots = dailyPoints.sublist(i, endIndex);

      // 주간 평균 계산
      double avgPrice =
          weekSpots.map((spot) => spot.y).reduce((a, b) => a + b) /
              weekSpots.length;
      weeklyPoints.add(FlSpot(weeklyPoints.length.toDouble(), avgPrice));

      // 주간 날짜 표시 (수~화)
      String startDate = dailyDates[i];
      String endDate = dailyDates[endIndex - 1];
      weeklyDates.add('$startDate~\n$endDate');
    }
  }

  Future<void> _fetchItemPriceHistory() async {
    try {
      final Map<String, dynamic>? data =
          await _itemService.getItemPriceHistory(widget.itemName);

      if (data != null) {
        List<String> dates = data.keys.toList()..sort();
        dailyPoints = [];
        dailyDates = [];
        double spotIndex = 0;

        for (var date in dates) {
          final priceData = data[date] as Map<String, dynamic>;

          final DateTime originalDate =
              DateTime.parse(date.replaceAll('.', '-'));
          final DateTime previousDay =
              originalDate.subtract(const Duration(days: 1));
          final String adjustedDate =
              previousDay.toString().substring(0, 10).replaceAll('-', '.');

          dailyPoints.add(
              FlSpot(spotIndex, (priceData['YDayAvgPrice'] as num).toDouble()));
          dailyDates.add(adjustedDate);
          spotIndex++;
        }

        dailyPoints.add(FlSpot(spotIndex, widget.currentPrice.toDouble()));
        final today = DateTime.now();
        dailyDates.add(today.toString().substring(0, 10).replaceAll('-', '.'));

        setState(() {
          _calculateWeeklyData();
          priceHistory = data;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching price history: $e');
      setState(() {
        isLoading = false;
        isError = true;
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
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? ErrorText(
                isError: isError,
                isWhite: Theme.of(context).brightness == Brightness.dark,
                isProgressWhite: false,
              )
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
                  if (dailyPoints.isNotEmpty)
                    Expanded(
                      child: BarGraph(
                          graphPoints: isDaily ? dailyPoints : weeklyPoints,
                          dates: isDaily ? dailyDates : weeklyDates,
                          isDaily: isDaily,
                          onChangeView: (bool daily) {
                            setState(() {
                              isDaily = daily;
                            });
                          }),
                    ),
                ],
              ),
      ),
    );
  }
}
