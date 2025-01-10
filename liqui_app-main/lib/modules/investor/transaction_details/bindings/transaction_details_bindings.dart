import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/transaction_details/controllers/transaction_details_controller.dart';

class TransactionsDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionDetailController());
  }
}
