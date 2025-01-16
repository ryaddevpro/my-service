import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartContent extends StatefulWidget {
  const LineChartContent({super.key});

  @override
  State<LineChartContent> createState() => _LineChartContentState();
}

class _LineChartContentState extends State<LineChartContent> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(
          border: Border(
            bottom: BorderSide(color: Colors.black),
          ),
        ),
        minX: 0,
        minY: 0,
        maxX: 12,
        maxY: 16,
        lineBarsData: [
          LineChartBarData(
            isCurved: false,
            spots: [
              FlSpot(0, 3),
              FlSpot(1, 4),
              FlSpot(2, 5),
              FlSpot(3, 6),
              FlSpot(4, 7),
              FlSpot(5, 8),
              FlSpot(6, 9),
              FlSpot(7, 10),
              FlSpot(8, 9),
              FlSpot(9, 11),
              FlSpot(10, 16),
              FlSpot(11, 7),
              FlSpot(12, 4),
            ],
          ),
        ],
        gridData: FlGridData(
          horizontalInterval: 2,
          drawHorizontalLine: true,
          checkToShowHorizontalLine: (value) =>
              true, // Show horizontal lines every 4 units
          getDrawingHorizontalLine: (value) {
            return FlLine(
              dashArray: [5, 6],
              strokeWidth: 0.3,
            );
          },
          drawVerticalLine: true,
          checkToShowVerticalLine: (value) =>
              false, // Show vertical lines every 3 units
          getDrawingVerticalLine: (value) {
            return FlLine(
              dashArray: [5, 6],
              strokeWidth: 0.3,
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 2,
              getTitlesWidget: (value, _) {
                if (value % 1 == 0) {
                  return Text(value.toInt().toString());
                }
                return Container();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 2,
              getTitlesWidget: (value, _) {
                if (value % 2 == 0) {
                  return Text(value.toInt().toString());
                }
                return Container();
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles()),
          topTitles: AxisTitles(sideTitles: SideTitles()),
        ),
      ),
    );
  }
}
