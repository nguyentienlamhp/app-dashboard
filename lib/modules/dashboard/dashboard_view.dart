import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';
import 'widgets/kpi_card.dart';
import 'widgets/charts/revenue_line_chart.dart';
import 'widgets/charts/debt_bar_chart.dart';
import 'widgets/charts/inventory_pie_chart.dart';
import 'widgets/charts/profit_waterfall_chart.dart';
import 'widgets/profile_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng quản trị', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          IconButton(icon: const Icon(Icons.remove), onPressed: () {}),
          IconButton(icon: const Icon(Icons.close), onPressed: () {}),
        ],
      ),
      body: Obx(() {
        return controller.currentIndex.value == 0
            ? _buildDashboardContent()
            : const ProfileView();
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          selectedItemColor: const Color(0xFF2563EB),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 1200 ? 4 : (constraints.maxWidth > 800 ? 2 : 1);
          
          return StaggeredGrid.count(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              const StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: KpiCard(
                  title: 'Doanh thu tháng',
                  value: '2.350.000.000 đ',
                  bottomWidget: Row(
                    children: [
                      Icon(Icons.arrow_upward, color: Colors.green, size: 16),
                      Text('12%', style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: crossAxisCount > 1 ? 2 : 1,
                child: const RevenueLineChart(),
              ),
              const StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: KpiCard(
                  title: 'Công nợ',
                  value: '920.000.000 đ',
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: crossAxisCount > 1 ? 2 : 1,
                child: const DebtBarChart(),
              ),
              const StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: KpiCard(
                  title: 'Tồn kho',
                  value: '5.600.000.000 đ',
                ),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: crossAxisCount > 1 ? 2 : 1,
                child: const InventoryChart(),
              ),
              StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: KpiCard(
                  title: 'Lợi nhuận',
                  value: '420.000.000 đ',
                  bottomWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.7, 
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF97316)),
                      minHeight: 6,
                    ),
                  ),
                ),
              ),
              
              StaggeredGridTile.fit(
                crossAxisCellCount: crossAxisCount > 1 ? 2 : 1,
                child: const ProfitWaterfallChart(),
              ),
            ],
          );
        },
      ),
    );
  }
}
