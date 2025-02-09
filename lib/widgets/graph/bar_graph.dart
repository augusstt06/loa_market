import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BarGraph extends StatelessWidget {
  final List<FlSpot> graphPoints;
  final List<String> dates;

  const BarGraph({
    super.key,
    required this.graphPoints,
    required this.dates,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        minY: graphPoints.map((point) => point.y).reduce(math.min) * 0.4,
        maxY: graphPoints.map((point) => point.y).reduce(math.max) * 1.05,
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: (graphPoints.map((point) => point.y).reduce(math.max) -
                      graphPoints.map((point) => point.y).reduce(math.min) *
                          0.4) /
                  5,
              getTitlesWidget: (value, meta) {
                if (value >= 10000) {
                  return Text(
                    '${(value / 10000).toStringAsFixed(0)}만',
                    style: const TextStyle(fontSize: 12),
                  );
                } else {
                  return Text(
                    value.toStringAsFixed(0),
                    style: const TextStyle(fontSize: 12),
                  );
                }
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < dates.length) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      dates[value.toInt()].substring(5),
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barGroups: graphPoints
            .map((point) => BarChartGroupData(
                  x: point.x.toInt(),
                  barRods: [
                    BarChartRodData(
                      toY: point.y,
                      color: Colors.blue,
                      width: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
