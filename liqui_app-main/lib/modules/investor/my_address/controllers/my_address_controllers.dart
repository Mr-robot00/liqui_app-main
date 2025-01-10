import 'package:get/get.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';

class MyAddressController extends GetxController {
  var isLoading = false.obs;
  var addressData = [].obs;
  var bankingId = ''.obs;

  //Error handling
  var errorMsg = ''.obs;
  var showError = false.obs;
  var retryError = ''.obs;

  void handleRetryAction() {
    updateLoading();
    switch (retryError.value) {
      case 'Basic_detail':
        fetchBasicDetail();
        break;
      default:
        updateError();
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchBasicDetail();
  }

  void fetchBasicDetail() async {
    final params = {'investor_id': myLocal.userId};
    updateError(isError: true);
    myRepo.fetchBasicDetail(query: params).asStream().handleError((error) {
      updateError(isError: true, msg: error.toString(), retry: 'Basic_detail');
    }).listen((response) {
      updateError();
      if (response.status!) {
        addressData.add(response.data!.address!.currentAddress!);
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'Basic_detail');
      }
    });
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  updateError({bool isError = false, String msg = '', String retry = ''}) {
    showError.value = msg.isNotEmpty ? isError : false;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError.value = retry;
  }
}
