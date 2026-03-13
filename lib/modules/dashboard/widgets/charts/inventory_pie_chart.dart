import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryChart extends StatelessWidget {
  const InventoryChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hàng tồn kho theo danh mục',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: Row(
                children: [
                  // Left side Horizontal Bar Chart equivalent
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildHorizontalBar(
                          'Cá mực',
                          2.1,
                          const Color(0xFF3B82F6),
                          0.7,
                        ),
                        const SizedBox(height: 16),
                        _buildHorizontalBar(
                          'Cá hồi',
                          1.5,
                          const Color(0xFF60A5FA),
                          0.5,
                        ),
                        const SizedBox(height: 16),
                        _buildHorizontalBar(
                          'Khác',
                          3.0,
                          const Color(0xFFF97316),
                          1.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Right side Pie Chart
                  Expanded(
                    flex: 1,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (
                                    FlTouchEvent event,
                                    PieTouchResponse? touchResponse,
                                  ) {
                                    if (event is FlTapUpEvent &&
                                        touchResponse != null &&
                                        touchResponse.touchedSection != null) {
                                      final section = touchResponse
                                          .touchedSection!
                                          .touchedSection;
                                      if (section != null &&
                                          section.title.isNotEmpty) {
                                        Get.snackbar(
                                          'Thông báo',
                                          'Tỉ lệ phần trăm: ${section.title.replaceAll('\n', ' ')}',
                                          snackPosition: SnackPosition.BOTTOM,
                                          margin: const EdgeInsets.all(16),
                                        );
                                      }
                                    }
                                  },
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: [
                              PieChartSectionData(
                                color: const Color(0xFF22C55E),
                                value: 30,
                                title: 'Cá mực\n30%',
                                radius: 40,
                                titleStyle: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: const Color(0xFF3B82F6),
                                value: 50,
                                title: 'Cá hồi\n50%',
                                radius: 40,
                                titleStyle: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                color: const Color(0xFFEA580C),
                                value: 20,
                                title: 'Khác\n20%',
                                radius: 40,
                                titleStyle: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalBar(
    String title,
    double value,
    Color color,
    double widthFactor,
  ) {
    return InkWell(
      onTap: () {
        Get.snackbar(
          'Thông báo',
          'Tồn kho $title: ${value}K',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      },
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: (widthFactor * 100).toInt(),
                  child: Container(height: 16, color: color),
                ),
                Expanded(
                  flex: ((1.0 - widthFactor) * 100).toInt(),
                  child: Container(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${value}K',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
