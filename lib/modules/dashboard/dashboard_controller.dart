import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Navigation
  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch data here
  }
}
