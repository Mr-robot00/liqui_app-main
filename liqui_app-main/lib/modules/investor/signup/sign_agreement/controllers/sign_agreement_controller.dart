import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import '../../../../../global/networking/my_repositories.dart';

class SignAgreementController extends GetxController {
  final signInValue = false.obs;

  //Error handling
  var errorMsg = ''.obs;
  var retryError = ''.obs;
  var isLoading = false.obs;
  var overlayLoading = true.obs;


  void callSignAgreement() async {
    final params = {
      'investor_id': myLocal.userId,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.signAgreement(params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'sign_agreement');
    }).listen((response) {
      updateError();
      if (response.status!) {
        logEvent.signAgreement();
        Get.offAllNamed(homeScreen);
      } else {
        updateError(isError: true, msg: response.message!);
      }
    });
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError.value) {
      case 'sign_agreement':
        callSignAgreement();
        break;
      default:
        updateError();
        break;
    }
  }

  updateError({bool isError = false, String msg = '', String retry = '', bool showOverlay = false,}) {
    myHelper.hideKeyboard();
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError.value = retry;
  }
}
