import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/responses/index.dart';
import 'package:liqui_app/global/config/responses/user_data_model.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/utils/helpers/date_time_helper.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';

import '../../../../../global/networking/my_repositories.dart';

class CreateInvestorController extends GetxController {
  final nameController = TextEditingController();
  final dateController = TextEditingController();
  final emailController = TextEditingController();
  final panController = TextEditingController();

  final panFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final dobFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  // var dob = '';
  var referralCode = '';
  var readOnly = true.obs;
  var gender = ''.obs;
  var fetchNameError = ''.obs;
  // var fetchPanError = ''.obs;
  // var fetchDateError = ''.obs;
  // var fetchEmailError = ''.obs;
  var disableButton = true.obs;
  var mobileNumber = '';
  var ckycNumber = '';
  bool registerFolio = false;

  //Error handling
  var errorMsg = ''.obs;
  var retryError = ''.obs;
  var isLoading = false.obs;
  var overlayLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      mobileNumber = Get.arguments['mobile_number'] ?? '';
      registerFolio = Get.arguments['for_register_folio'] ?? false;
      if (registerFolio) {
        nameController.text = myLocal.userDataConfig.userName;
        emailController.text = myLocal.userDataConfig.userEmail;
        panController.text = myLocal.userDataConfig.userPAN;
        gender.value = myLocal.userDataConfig.userGender.toLowerCase();
        dateController.text = myLocal.userDataConfig.userDob.isNotEmpty
            ? dtHelper.getFormattedDate(
                myLocal.userDataConfig.userDob.toString(),
                inFormat: 'yyyy-MM-dd',
                outFormat: 'dd-MMM-yyyy')
            : "";
        if (panController.text.isPanValid) callVerifyPan();
        updateButtonState();
      }
    }

    dobFocusNode.addListener(() {
      if (dobFocusNode.hasFocus) openDOBSheet();
    });

    referralCode = myLocal.referralCode;
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    emailController.dispose();
    panController.dispose();

    panFocusNode.dispose();
    nameFocusNode.dispose();
    dobFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  void openDOBSheet() {
    dobFocusNode.unfocus();
    myWidget
        .selectDate(dateController)
        .then((_) => emailFocusNode.requestFocus());
  }

  void callVerifyPan() async {
    final params = {
      'pan_card': panController.text,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.verifyPanCard(params).asStream().handleError((error) {
      updateError(
          isError: true,
          msg: error.toString(),
          retry: 'verify_pan' /*retry: 'verify_pan'*/
          );
    }).listen((response) {
      updateError();
      if (response.status!) {
        nameController.text = response.data!.name!;
        readOnly.value = true;
        fetchNameError.value = '';
      } else {
        readOnly.value = false;
        nameFocusNode.requestFocus();
        fetchNameError.value = response.message!;
      }
    });
  }

  void callUpdateGender() async {
    final params = {
      'investor_id': myLocal.userId,
      'gender': gender.value.capitalizeFirst,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.updateInvestor(params).asStream().handleError((error) {
      updateError(
        isError: true,
        msg: error.toString(),
      );
    }).listen((response) {
      updateError();
      if (response.status!) {
        Get.toNamed(addAddressScreen);
      } else {
        updateError(isError: true, msg: response.message!);
      }
    });
  }

  void callVerifyCKYC() async {
    final params = {
      'id_no': panController.text,
      'mobile_no': mobileNumber,
      'id_type': 'C',
      "type": 'mobile_no',
      // 'source': "Ifa",
    };
    updateError(isError: true, showOverlay: true);
    myRepo.verifyCKYC(params).asStream().handleError((error) {
      updateError(isError: true, msg: error.toString());
    }).listen((response) async {
      updateError();
      if (response.status!) {
        ckycNumber = response.ckycData!.ckycno!;
      } else {
        ckycNumber = "";
        // updateError(
        //     isError: true, msg: response.message!, retry: "verify_ckyc");
      }
      callCreateInvestor();
    });
  }

  void callCreateInvestor() async {
    final investorProfile = {
      'pan': panController.text,
      'name': nameController.value.text,
      'name_fetched_by': readOnly.value ? 'Api' : 'Manual',
      'email': emailController.value.text,
      'ifa_id': myLocal.getIfaCode ?? myLocal.appConfig.appIfaId ?? '4211',
      'contact_number': mobileNumber,
      'dob': dtHelper.getFormattedDate(dateController.value.text,
          inFormat: 'dd-MMM-yyyy', outFormat: 'yyyy-MM-dd'),
      'onboarding_source': referralCode.isEmpty ? 'mobile' : 'mobileReferral',
      "loginType": 'mobile',
      'device_id': myLocal.deviceUniqueId,
      'fcm_token': myLocal.fcmDeviceToken,
      // "holding_type": "RIA",
    };
    var otherDetails = {};
    var kycDetails = {};
    otherDetails.addIf(referralCode.validString, "referral_code", referralCode);
    kycDetails.addIf(ckycNumber.validString, "ckyc_number", ckycNumber);

    final params = {
      'personal_details': investorProfile,
      "other_details": otherDetails,
      "kyc_details": kycDetails,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.createInvestor(params).asStream().handleError((error) {
      updateError(
        isError: true,
        msg: error.toString(), /*retry: 'create_investor'*/
      );
    }).listen((response) async {
      updateError();
      if (response.status!) {
        var res = response.data as CreateInvestorModel;
        var investorId = res.investorId.toString();
        var investorName = nameController.text;
        var investorEmail = emailController.text;

        myLocal.authToken = res.token!;
        if (!registerFolio) {
          var userdata = UserData(
              userId: investorId,
              userName: nameController.text,
              userNumber: mobileNumber,
              userEmail: emailController.text,
              userPAN: panController.text,
              userDob: dtHelper.getFormattedDate(dateController.value.text,
                  inFormat: 'dd-MMM-yyyy', outFormat: 'yyyy-MM-dd'),
              userGender: gender.value);
          myLocal.userData = userdata;
        } else {
          myLocal.ifaId =
              myLocal.getIfaCode ?? myLocal.appConfig.appIfaId ?? '4211';
        }
        myLocal.userId = investorId;
        myLocal.isLoggedIn = true;
        await logEvent.setUserIdentify(investorId: investorId);
        logEvent.setUserAttributes(
            investorId: investorId,
            userName: investorName,
            emailId: investorEmail,
            mobileNumber: mobileNumber);
        await logEvent.createInvestor(
            source: registerFolio ? "popup_chooseFolio" : "page_Otp");
        myLocal.clearDeepLinkData();
        callUpdateGender();
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
      case 'verify_pan':
        callVerifyPan();
        break;
      case 'verify_ckyc':
        callVerifyCKYC();
        break;
      case 'create_investor':
        callCreateInvestor();
        break;
      case 'update_investor':
        callUpdateGender();
        break;
      default:
        updateError();
        break;
    }
  }

  String? get nameErrorMsg {
    return fetchNameError.value.validString ? fetchNameError.value : null;
  }

  updateTextError(String value, RxString error) {
    if (value.isNotEmpty) {
      error.value = '';
    }
    updateButtonState();
  }

  void updateButtonState() {
    var isDisabled =
        (panController.text.length != 10 && panController.text.isPanValid) ||
            dateController.text.isEmpty ||
            nameController.text.length < 3 ||
            gender.value.isEmpty ||
            emailController.text.isEmpty ||
            (emailController.text.isNotEmpty &&
                !emailController.text.isEmailIdValid);
    disableButton.value = isDisabled;
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
