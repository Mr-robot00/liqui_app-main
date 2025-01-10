import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/dashboard/controllers/dashboard_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}