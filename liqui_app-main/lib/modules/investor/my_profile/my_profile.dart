import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';

import '../../../../global/config/routes/app_routes.dart';
import '../../../../global/constants/app_constants.dart';
import '../../../global/widgets/my_app_bar.dart';

class MyProfile extends StatelessWidget {
  // final TransactionsController trans = Get.find();
  // final DashboardController dash = Get.find();
  // final ProfileController profile = Get.find();

  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      appBar: MyAppBar(
        title: "my_profile".tr,
      ),
      body: listSection(),
    );
  }

  Widget listSection() {
    final List<Map> items = [
      {
        "id": 1,
        "title": 'basic_information'.tr,
        "icon": "user",
        "isLeadingVisible": true
      },
      {
        "id": 2,
        "title": "my_bank_accounts".tr,
        "icon": "bank",
        "isLeadingVisible": true
      },
      {
        "id": 3,
        "title": "my_address".tr,
        "icon": "address",
        "isLeadingVisible": true
      },
    ];

    return Padding(
        padding: const EdgeInsets.all(padding16),
        child: Column(
            children: ListTile.divideTiles(
                color: Get.theme.scaffoldBackgroundColor,
                tiles: items.map((item) => ListTile(
                      leading: (myHelper.getAssetImage(item['icon'])),
                      title: Text(
                        item['title'],
                        style: myStyle.myFontStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: (item['isLeadingVisible']
                          ? const Icon(Icons.chevron_right, size: padding22)
                          : null),
                      onTap: () {
                        onClick(item['id']);
                      },
                    ))).toList()));
  }

  Future<void> onClick(int id) async {
    switch (id) {
      case 1:
        navigateToScreen(basicDetailsScreen);
        logEvent.buttonBasicInformation(
            page: "page_${myProfileScreen.substring(1)}");
        break;
      case 2:
        if (myLocal.ifaId.isNotEmpty) {
          navigateToScreen(bankAccountsScreen);
          logEvent.buttonMyBankDetails(
              page: "page_${myProfileScreen.substring(1)}");
        } else {
          myHelper.chooseFolio(
            page: "page_${myProfileScreen.substring(1)}",
            source: "button_my_bank_account".tr,
            onChanged: () {
              navigateToScreen(bankAccountsScreen);
              // updateFolioDetails();
            },
          );
        }
        break;
      case 3:
        logEvent.buttonMyAddress(page: "page_${myProfileScreen.substring(1)}");
        navigateToScreen(myAddressScreen);
        break;
    }
  }

  void navigateToScreen(String route) {
    Get.toNamed(route);
  }

  // updateFolioDetails() {
  //   navigateToScreen(bankAccountsScreen);
  // }
}
