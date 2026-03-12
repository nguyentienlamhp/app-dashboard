import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RevenueLineChart extends StatelessWidget {
  const RevenueLineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Doanh thu theo thời gian',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 260,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
                      if (event is FlTapUpEvent && touchResponse != null && touchResponse.lineBarSpots != null) {
                        final value = touchResponse.lineBarSpots!.first.y;
                        Get.snackbar(
                          'Thông báo', 
                          'Doanh thu: ${value.toInt()} Tr',
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(16),
                        );
                      }
                    },
                    handleBuiltInTouches: true,
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 500,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: Color(0xFFE5E7EB),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgets,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 500,
                        getTitlesWidget: leftTitleWidgets,
                        reservedSize: 42,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 3000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 1900),
                        FlSpot(1, 1800),
                        FlSpot(2, 2200),
                        FlSpot(3, 2500),
                        FlSpot(4, 2600),
                        FlSpot(5, 2200),
                        FlSpot(6, 2600),
                      ],
                      isCurved: false,
                      color: const Color(0xFF2563EB),
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF2563EB).withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black54, fontSize: 12);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Tháng 1', style: style);
        break;
      case 1:
        text = const Text('Tháng 2', style: style);
        break;
      case 2:
        text = const Text('Tháng 3', style: style);
        break;
      case 3:
        text = const Text('Tháng 4', style: style);
        break;
      case 4:
        text = const Text('Tháng 5', style: style);
        break;
      case 5:
        text = const Text('Tháng 6', style: style);
        break;
      case 6:
        text = const Text('Tháng 7', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      //axisSide: meta.axisSide,
      meta: meta,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black54, fontSize: 12);
    return Text('${value.toInt()} Tr', style: style, textAlign: TextAlign.left);
  }
}
