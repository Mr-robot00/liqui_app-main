import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/signup/create_investor/controllers/create_investor_controller.dart';

class CreateInvestorBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateInvestorController());
  }
}