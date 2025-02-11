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

  BarChartData _createMainChartData() {
    return BarChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey.withOpacity(0.2),
          strokeWidth: 1,
        ),
      ),
      minY: graphPoints.map((point) => point.y).reduce(math.min) * 0.6,
      maxY: graphPoints.map((point) => point.y).reduce(math.max) * 1.1,
      titlesData: _createTitlesData(),
      barGroups: _createBarGroups(),
    );
  }

  BarChartData _createYAxisChartData() {
    return BarChartData(
      minY: _createMainChartData().minY,
      maxY: _createMainChartData().maxY,
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval:
                (_createMainChartData().maxY - _createMainChartData().minY) / 5,
            getTitlesWidget: _yAxisTitleWidget,
          ),
        ),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      barGroups: [],
    );
  }

  Widget _yAxisTitleWidget(double value, TitleMeta meta) {
    if (value >= 10000) {
      return Text(
        '${(value / 10000).toStringAsFixed(0)}만',
        style: const TextStyle(fontSize: 12),
      );
    }
    return Text(
      value.toStringAsFixed(0),
      style: const TextStyle(fontSize: 12),
    );
  }

  FlTitlesData _createTitlesData() {
    return FlTitlesData(
      show: true,
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return graphPoints
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
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: BarChart(_createYAxisChartData()),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: math.max(
                MediaQuery.of(context).size.width - 40,
                graphPoints.length * 50.0,
              ),
              child: BarChart(_createMainChartData()),
            ),
          ),
        ),
      ],
    );
  }
}
