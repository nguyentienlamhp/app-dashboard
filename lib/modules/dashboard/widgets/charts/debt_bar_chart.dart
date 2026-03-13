import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DebtBarChart extends StatelessWidget {
  const DebtBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Công nợ theo thời hạn',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 600,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchCallback: (FlTouchEvent event, BarTouchResponse? touchResponse) {
                      if (event is FlTapUpEvent && touchResponse != null && touchResponse.spot != null) {
                        final value = touchResponse.spot!.touchedRodData.toY;
                        Get.snackbar(
                          'Thông báo', 
                          'Công nợ: ${value.toInt()} Tr',
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(16),
                        );
                      }
                    },
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.toY.round()} Tr',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 100,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 120, // To match 50, 120, 250, 500 roughly
                    getDrawingHorizontalLine: (value) {
                       return const FlLine(color: Color(0xFFE5E7EB), strokeWidth: 1);
                    }
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                            toY: 500, color: const Color(0xFF3B82F6), width: 40, borderRadius: BorderRadius.zero),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                            toY: 250, color: const Color(0xFFFBBF24), width: 40, borderRadius: BorderRadius.zero),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                            toY: 120, color: const Color(0xFFF97316), width: 40, borderRadius: BorderRadius.zero),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                            toY: 50, color: const Color(0xFFEF4444), width: 40, borderRadius: BorderRadius.zero),
                      ],
                      showingTooltipIndicators: [0],
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

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black54, fontSize: 12);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '< 30 Ngày';
        break;
      case 1:
        text = '30-60 Ngày';
        break;
      case 2:
        text = '60-90 Ngày';
        break;
      case 3:
        text = '> 90 Ngày';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      meta: meta,
      angle: -0.5,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == 50 || value == 120 || value == 250 || value == 500) {
      return Text('${value.toInt()} Tr', style: const TextStyle(color: Colors.black54, fontSize: 12));
    }
    return const SizedBox.shrink();
  }
}
