import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/modules/investor/bank_accounts/controllers/bank_accounts_controller.dart';
import 'package:liqui_app/modules/investor/upload_bank_document/models/document_list_response.dart';

import '../../../../global/config/routes/app_routes.dart';

class UploadBankDocumentController extends GetxController {
  var isLoading = false.obs;
  var docRes = DocumentListResponse();
  final TextEditingController documentValue = TextEditingController();
  var docs = <KYCDocModel>[].obs;
  var imagePath = ''.obs;
  var disableButton = true.obs;
  var showProofError = false.obs;
  String docType = Get.parameters["doc_type"]!;
  var addBank = false.obs;

  //Error handling
  var errorMsg = ''.obs;
  var retryError = ''.obs;
  var overlayLoading = true.obs;

  void handleRetryAction() {
    updateLoading();
    switch (retryError.value) {
      case 'fetch_doc_list':
        fetchDocumentList();
        break;
      case 'profile_details':
        callGetBasicDetail();
        break;
      case 'upload_kyc_doc':
        postUploadKYCDocuments();
        break;
      default:
        updateError();
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchDocumentList();
    if (Get.arguments != null) {
      addBank.value = Get.arguments['add_another_bank'] ?? false;
    }
  }

  @override
  void dispose() {
    documentValue.dispose();
    super.dispose();
  }

  void fetchDocumentList() async {
    final params = {'investor_id': myLocal.userId};
    updateError(isError: true);
    myRepo.fetchDocumentList(query: params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'fetch_doc_list');
    }).listen((response) {
      updateError();
      if (response.status!) {
        docRes = response;
        kycDocs(docType);
        if (docs.length == 1) {
          documentValue.text = docs[0].label;
        }
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'fetch_doc_list');
      }
    });
  }

  // Doc type can be:
  // 'Proof of Identity'
  // 'Proof Of Address'
  // 'Banking'
  void kycDocs(String type) {
    String panNumber = myLocal.userDataConfig.userPAN;
    if (docRes.data == null) docs.value = [];
    Map<String, dynamic> list = jsonDecode(docRes.data!);
    if (list[panCharAbbreviation[panNumber[3]]] == null) docs.value = [];
    Map<String, dynamic> panType = list[panCharAbbreviation[panNumber[3]]];
    List<dynamic> documents = panType[type];
    var filterList = documents.where((element) =>
        element["document_id"] != null && element["document_type"] != null);
    var result = filterList
        .map((doc) => KYCDocModel(doc["document_id"], doc["document_type"]))
        .toList();
    docs.value = result;
  }

  Map<String, String> get panCharAbbreviation => {
        "P": 'Individual',
        "H": 'HUF',
        "C": 'Private Ltd',
        "F": 'Limited Liability Partnership',
        "T": 'Trust',
        "B": 'Society',
        "A": 'Association of Persons',
      };

  void validateForm([bool btnClick = false]) {
    if (imagePath.value.isEmpty || documentValue.text.isEmpty) {
      disableButton.value = true;
      if (documentValue.text.isEmpty) {
        showProofError.value = true;
      } else {
        showProofError.value = false;
      }
    } else {
      disableButton.value = false;
      if (btnClick) {
        postUploadKYCDocuments();
      }
    }
  }

  void postUploadKYCDocuments() async {
    final params = {
      'investor_id': myLocal.userId,
      "document_type": documentValue.text,
      "file": myHelper.base64StringFromPath(imagePath.value),
      "created_by": null,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.uploadKYCDocuments(params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'upload_kyc_doc');
    }).listen((response) {
      updateError();
      if (response.status) {
        Get.showSnackBar(response.message);
        if (addBank.value) {
          final bank = Get.find<BankAccountsController>();
          bank.fetchInvestorBankDetails();
          Get.until((route) => Get.currentRoute == bankAccountsScreen);
        } else {
          if (docType == "Banking") {
            callGetBasicDetail();
            // Get.offNamed(uploadPanDocumentScreen);
          } else if (docType == "Proof of Identity") {
            Get.offNamed(uploadAddressDocumentScreen);
          } else if (docType == "Proof Of Address") {
            Get.offNamed(signInAgreementScreen);
          }
        }
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'upload_kyc_doc');
      }
    });
  }

  callGetBasicDetail() async {
    updateError(isError: true, showOverlay: true);
    try {
      var result =
          await myRepo.fetchBasicDetail(query: {'investor_id': myLocal.userId});
      updateError();
      if (result.status!) {
        Get.offNamed(result.data!.profile!.ckycNumber.validString
            ? signInAgreementScreen
            : uploadPanDocumentScreen);
      } else {
        updateError(
            isError: true, msg: result.message!, retry: 'profile_details');
      }
    } catch (e) {
      updateError(isError: true, msg: e.toString(), retry: 'profile_details');
    }
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  updateError({
    bool isError = false,
    String msg = '',
    String retry = '',
    bool showOverlay = false,
  }) {
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError.value = retry;
  }
}
