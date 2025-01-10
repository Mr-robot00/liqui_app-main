import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/make_payment/controllers/make_payment_controller.dart';

class MakePaymentBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MakePaymentController());
  }

}