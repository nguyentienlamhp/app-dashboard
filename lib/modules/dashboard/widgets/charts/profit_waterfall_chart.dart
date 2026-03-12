import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfitWaterfallChart extends StatelessWidget {
  const ProfitWaterfallChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Báo cáo Lãi / Lỗ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 2000,
                  minY: 0, 
                  groupsSpace: 12,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchCallback: (FlTouchEvent event, BarTouchResponse? touchResponse) {
                      if (event is FlTapUpEvent && touchResponse != null && touchResponse.spot != null) {
                        final value = touchResponse.spot!.touchedRodData.toY;
                        final index = touchResponse.spot!.touchedBarGroupIndex;
                        final titles = ['Doanh thu', 'Giá vốn', 'Chi phí', 'Khác', 'Lợi nhuận'];
                        Get.snackbar(
                          'Thông báo', 
                          '${titles[index]}: ${value.toInt()} Tr',
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.all(16),
                        );
                      }
                    },
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
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 500,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(color: Color(0xFFE5E7EB), strokeWidth: 1);
                    }
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    // Doanh thu (Full bar)
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 2000,
                          fromY: 0,
                          color: const Color(0xFF22C55E),
                          width: 40,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    // Giá vốn (Starts from 2000 goes down by 1200 -> to 800)
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 2000, // Top
                          fromY: 800, // Bottom
                          color: const Color(0xFFEF4444),
                          width: 40,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    // Chi phí (Starts from 800 goes down by 300 -> to 500)
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 800, // Top
                          fromY: 500, // Bottom
                          color: const Color(0xFFEF4444),
                          width: 40,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    ),
                    // Lợi nhuận (Starts from 500 goes down by some offset, actually a custom positive block)
                    // The image has a negative offset before Lợi Nhuận, but Lợi Nhuận is 500 Tr. We will put Lợi Nhuận from 0 to 500.
                     BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 500, // Bottom
                          fromY: 400, // Simulate a small gap
                           color: const Color(0xFFF59E0B),
                           width: 40,
                           borderRadius: BorderRadius.zero,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                          toY: 500, // Top
                          fromY: 0, // Bottom
                          color: const Color(0xFF22C55E),
                          width: 40,
                          borderRadius: BorderRadius.zero,
                        ),
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
        text = 'Doanh thu';
        break;
      case 1:
        text = 'Giá vốn';
        break;
      case 2:
        text = 'Chi phí';
        break;
      case 3:
        text = 'Khác';
        break;
      case 4:
        text = 'Lợi nhuận';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      //axisSide: meta.axisSide,
      meta: meta,
      child: Text(text, style: style),
    );
  }
}
