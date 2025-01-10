import 'package:get/get.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/modules/investor/select_folio/models/investor_hierarchy_response.dart';

class HierarchyController extends GetxController {
  var isLoading = false.obs;
  var ifaData = <InvestorHierarchyModel>[].obs;

  //Error handling
  var errorMsg = ''.obs;
  var retryError = "";
  var overlayLoading = true.obs;

  Future<void> onPullRefresh() async {
    callGetInvestorHierarchy();
  }

  List<InvestorHierarchyModel> folios({bool showAllFolio = false}) {
    List<InvestorHierarchyModel> list = [];
    list.addAll(ifaData);
    var allFolios = InvestorHierarchyModel(ifaId: 0, ifaName: "All Folios");
    if (list.length > 1 && showAllFolio) {
      if (list
          .where((folio) => folio.ifaName! == "All Folios")
          .toList()
          .isEmpty) {
        list.insert(0, allFolios);
      }
    }
    if (!showAllFolio) {
      list = list.where((folio) => folio.ifaName != "All Folios").toList();
    }
    ifaData.value = list;
    return list;
  }

  bool get showRegisterButton {
    for (var element in ifaData) {
      var status = myHelper.isIFAValid(
          id: element.ifaId.toString(), showInvalidAlert: false);
      if (element.ifaId != 0 && status) return false;
    }
    return true;
  }

  void selectFolio(InvestorHierarchyModel details) {
    var allFoliosSelected = details.ifaName == "All Folios";
    myLocal.ifaId = allFoliosSelected ? "" : details.ifaId.toString();
    myLocal.ifaName = allFoliosSelected ? "" : details.ifaName.toString();
    myLocal.userId = allFoliosSelected
        ? myLocal.investorId
        : details.familyMembers![0].investorId.toString();
  }

  Future<List<dynamic>> callGetInvestorHierarchy() async {
    var result = [];
    final params = {'investor_id': myLocal.investorId};
    updateError(isError: true, showOverlay: true);
    myRepo.investorHierarchy(query: params).asStream().handleError((error) {
      result = [false, error.toString()];
      updateError(
          isError: true, msg: error.toString(), retry: 'investor_hierarchy');
      myLocal.ifaId = "";
      myLocal.ifaName = "";
    }).listen((response) async {
      updateError();
      if (response.status!) {
        ifaData.value = response.hierarchyDetails ?? [];
        //show options
        folios();
        if (response.hierarchyDetails!.length == 1) {
          selectFolio(response.hierarchyDetails![0]);
        } else {
          myLocal.ifaId = "";
          myLocal.ifaName = "";
        }
      } else {
        updateError(
            isError: true, msg: response.message!, retry: 'investor_hierarchy');
      }
      result = [response.status!, response.message!];
    });
    while (result.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return result;
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError) {
      case 'investor_hierarchy':
        callGetInvestorHierarchy();
        break;
      default:
        updateError();
        break;
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
    retryError = retry;
  }
}
