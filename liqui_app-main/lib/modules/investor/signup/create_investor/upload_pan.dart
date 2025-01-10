import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/app_constants.dart';
import '../../../../global/widgets/index.dart';

class UploadPan extends GetView {
  const UploadPan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode?Colors.black54:Colors.white54,
        appBar: const MyAppBar(
          title: 'Upload Pan',
        ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                   children: [
                     Center(
                       child: MyOutlinedButton(
                         margin:  const EdgeInsets.symmetric(
                             horizontal: padding20, vertical: padding10),
                         onPressed:() => myWidget.uploadFilePopUp(),
                         title: 'add_file'.tr,
                       ),
                     )
                   ],
              ),
            ),
          ),
          MyButton(
            margin:  const EdgeInsets.symmetric(
                horizontal: padding20, vertical: padding10),
            onPressed: null,
            title: 'upload_now'.tr,
          )
        ],
      ),
    );
  }


}
