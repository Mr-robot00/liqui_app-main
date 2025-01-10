import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/deposit_funds/controllers/deposit_funds_controller.dart';
import 'package:liqui_app/modules/investor/withdraw_fund/controllers/withdraw_fund_controller.dart';

class TransactionStatusController extends GetxController {
  var title = ''.obs;
  var withdrawScreen = true.obs;
  var selectedAmount = "";
  var selectedBankName = "";
  var transactionId = '';
  late DepositFundsController depositController;
  late WithdrawFundController withdrawController;

  @override
  void onInit() {
    if (Get.arguments != null) {
      title.value = Get.arguments['title'].toString();
      withdrawScreen.value = Get.arguments['withdrawScreen'] ?? true;
      if (!withdrawScreen.value) {
        transactionId = Get.arguments['transactionId'] ?? "";
      }
    }

    if (withdrawScreen.value) {
      withdrawController = Get.find<WithdrawFundController>();
      String test = withdrawController.bankListData
          .firstWhere((element) =>
              element.id.toString() == withdrawController.selectedValue!.id.toString())
          .ifsc!;
      int numSpace = 6;
      selectedBankName = test.replaceRange(4, numSpace, 'X' * numSpace);
      selectedAmount = withdrawController.amountController.text;
    } else {
      depositController  = Get.find<DepositFundsController>();
      selectedAmount = depositController.amountController.text;
    }
    super.onInit();
  }
}
