import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/home/controllers/home_controller.dart';
import 'package:liqui_app/modules/investor/select_folio/controllers/hierarchy_controller.dart';

class SelectFolio extends GetView<HierarchyController> {
  final bool showAllFolio;

  const SelectFolio({
    Key? key,
    this.showAllFolio = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'choose_folio'.tr),
      body: Obx(
        () => OverlayScreen(
          isLoading: controller.isLoading.value,
          errorMessage: controller.errorMsg.value,
          onRetryPressed: () => controller.handleRetryAction(),
          onDismissPressed: () => controller.updateLoading(),
          backgroundColor: controller.overlayLoading.value
              ? Get.isDarkMode
                  ? Colors.black54
                  : Colors.white54
              : Get.theme.scaffoldBackgroundColor,
          child: body,
        ),
      ),
    );
  }

  Widget get body {
    final folios = controller.folios(showAllFolio: showAllFolio);
    //Here folio id 0 is set for All Folio option
    final selectedFolio = (myLocal.ifaId.isEmpty ? "0" : myLocal.ifaId).obs;
    return RefreshIndicator(
      onRefresh: controller.onPullRefresh,
      child: folios.isNotEmpty
          ? Column(
              children: [
                ListView.separated(
                  itemCount: controller.ifaData.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var folio = controller.ifaData[index];
                    return Column(
                      children: [
                        Obx(
                          () => ListTile(
                            onTap: () {
                              if (selectedFolio.value !=
                                  folio.ifaId.toString()) {
                                selectedFolio.value = folio.ifaId.toString();
                              }
                            },
                            leading: CircleAvatar(
                              backgroundColor: primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(padding2),
                                //border size
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    folio.ifaName![0]
                                        .toLowerCase()
                                        .capFirstOfEach,
                                    style: myStyle.myFontStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize20),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              folio.ifaName!.toLowerCase().capFirstOfEach,
                              style: myStyle.myFontStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: fontSize16),
                            ),
                            trailing: Icon(
                              selectedFolio.value == folio.ifaId.toString()
                                  ? Icons.check_circle
                                  : Icons.radio_button_off,
                              color: primaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: padding16);
                  },
                ),
                const SizedBox(height: padding16),
                MyButton(
                    margin: const EdgeInsets.symmetric(vertical: padding20),
                    onPressed: () {
                      var validSelection = selectedFolio.value != myLocal.ifaId;
                      var selected = controller.ifaData.firstWhere((folio) =>
                          folio.ifaId.toString() == selectedFolio.value);
                      if (validSelection) {
                        controller.selectFolio(selected);
                        HomeController home = Get.find();
                        home.updateFolioDetails();
                        Get.back(result: validSelection);
                      }
                    },
                    title: "continue".tr),
                if (controller.showRegisterButton)
                  Column(
                    children: [
                      Row(children: <Widget>[
                        _divider,
                        Text(
                          "or".tr,
                          style: myStyle.myFontStyle(
                              color: Get.isDarkMode
                                  ? grayLightColor
                                  : fontDesColor,
                              fontSize: fontSize16),
                        ),
                        _divider,
                      ]),
                      const SizedBox(height: padding10),
                      MyOutlinedButton(
                          avoidIntrusions: true,
                          margin:
                              const EdgeInsets.symmetric(vertical: padding16),
                          onPressed: () {
                            Get.offNamed(createInvestorScreen, arguments: {
                              "mobile_number":
                                  myLocal.userDataConfig.userNumber,
                              "for_register_folio": true
                            });
                          },
                          title: "create_new_liquiloans_account".tr),
                    ],
                  ),
              ],
            )
          : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(padding16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "no_data_found".tr,
                    style: myStyle.myFontStyle(fontSize: fontSize18),
                  ),
                  const SizedBox(height: padding10),
                  MyButton(
                    onPressed: controller.onPullRefresh,
                    title: "refresh".tr,
                    minimumSize: const Size(0, 40),
                  )
                ],
              ),
            ),
    );
  }

  Widget get _divider {
    return Expanded(
      child: Divider(
        endIndent: 10,
        indent: 20,
        color: Get.isDarkMode ? grayLightColor : blackColor,
        height: padding35,
      ),
    );
  }
}
