import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/transactions/controllers/transactions_controller.dart';

class TransactionsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionsController());
  }
}