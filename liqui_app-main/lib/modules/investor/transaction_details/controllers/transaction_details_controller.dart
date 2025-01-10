import 'package:get/get.dart';

import '../../../../global/networking/my_repositories.dart';
import '../../../../global/utils/storage/my_local.dart';
import '../models/transaction_details_response.dart';

class TransactionDetailController extends GetxController {
  var isLoading = false.obs;
  var transactionModel = <TransactionDataModel>[].obs;
  var transactionId = '0'; //'95724249'
  var currentValue = '0';
  var utr = '';

  //Error handling
  var errorMsg = ''.obs;
  var retryError = ''.obs;
  var overlayLoading = true.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      transactionId = Get.arguments['transaction_id'];
    }
    callGetTransactionDetail();
    super.onInit();
  }

  void callGetTransactionDetail() {
    final params = {
      'investor_id': myLocal.userId,
      'portfolio_id': transactionId
    };
    updateError(isError: true);
    myRepo.transactionDetail(query: params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'transaction_details');
    }).listen((response) {
      updateError();
      if (response.status!) {
        transactionModel.value = response.data!.data!;
        currentValue = response.data!.currentValue?.toStringAsFixed(2) ?? '0';
        utr = response.data!.utr ?? '';
      } else {}
    });
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError.value) {
      case 'transaction_details':
        callGetTransactionDetail();
        break;
      default:
        updateError();
        break;
    }
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  updateError(
      {bool isError = false,
      String msg = '',
      String retry = '',
      bool showOverlay = false}) {
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError.value = retry;
  }
}
