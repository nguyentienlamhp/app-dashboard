import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;

  void login() {
    // Basic mock navigation
    Get.offNamed(Routes.DASHBOARD);
  }
}
