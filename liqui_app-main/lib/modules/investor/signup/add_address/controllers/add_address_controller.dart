import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';

import '../../../../../global/networking/my_repositories.dart';
import '../../../../../global/utils/helpers/my_helper.dart';
import '../../../../../global/utils/storage/my_local.dart';

class AddAddressController extends GetxController {
  final pinCodeController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final addressOneController = TextEditingController();
  final addressTwoController = TextEditingController();

  final address1FocusNode = FocusNode();
  final address2FocusNode = FocusNode();

  var fetchStateError = ''.obs;
  var fetchCityError = ''.obs;
  var disableButton = true.obs;

  var fromAddAddrees = false.obs;

  //Error handling
  var errorMsg = ''.obs;
  var retryError = ''.obs;
  var isLoading = false.obs;
  var overlayLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      fromAddAddrees.value = Get.arguments['fromKyc'];
    }
  }

  @override
  void dispose() {
    pinCodeController.dispose();
    stateController.dispose();
    cityController.dispose();
    addressOneController.dispose();
    addressTwoController.dispose();

    address1FocusNode.dispose();
    address2FocusNode.dispose();

    super.dispose();
  }

  void callVerifyPinCode() async {
    final params = {
      'investor_id': myLocal.userId,
      'pin_code': pinCodeController.text
    };
    updateError(isError: true, showOverlay: true);
    myRepo.verifyPinCode(params).asStream().handleError((error) {
      updateError(
        isError: true,
        msg: error.toString(), /* retry: 'verify_pinCode'*/
      );
    }).listen((response) {
      updateError();
      if (response.status!) {
        cityController.text = response.data?.district ?? '';
        stateController.text = response.data?.state ?? '';
        fetchCityError.value = ''.tr;
        fetchStateError.value = ''.tr;
      } else {
        cityController.text = '';
        stateController.text = '';
        fetchCityError.value = 'cannot_fetch_city'.tr;
        fetchStateError.value = 'cannot_fetch_state'.tr;
        //updateError(isError: true, msg: response.message.toString());
      }
      address1FocusNode.requestFocus();
      updateButtonState();
    });
  }

  void callCreateAddress() async {
    final params = {
      'investor_id': myLocal.userId,
      'pin_code': pinCodeController.text,
      'city': cityController.value.text,
      'state': stateController.value.text,
      'address_line_1': addressOneController.text,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.addAddress(params).asStream().handleError((error) {
      updateError(
        isError: true,
        msg: error.toString(), /*retry: 'add_address'*/
      );
    }).listen((response) {
      // check model before adding anything to data
      updateError();
      if (response.status!) {
        Get.toNamed(addBankAccountScreen);
      } else {
        updateError(isError: true, msg: response.message.toString());
      }
    });
  }

  void updateButtonState() {
    var isDisabled = pinCodeController.text.length != 6 ||
        addressOneController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty;
    disableButton.value = isDisabled;
  }

  String? get stateErrorMsg {
    return fetchStateError.value.validString ? fetchStateError.value : null;
  }

  String? get cityError {
    return fetchCityError.value.validString ? fetchCityError.value : null;
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError.value) {
      case 'verify_pinCode':
        callVerifyPinCode();
        break;
      case 'add_address':
        callCreateAddress();
        break;
      default:
        updateError();
        break;
    }
  }

  updateError({
    bool isError = false,
    String msg = '',
    String retry = '',
    bool showOverlay = false,
  }) {
    myHelper.hideKeyboard();
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError.value = retry;
  }
}
