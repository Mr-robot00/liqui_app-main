import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/modules/investor/home/controllers/home_controller.dart';

import 'index.dart';

class OverlayScreen extends StatefulWidget {
  final bool isLoading;
  final Color? backgroundColor;
  final Widget? progressIndicator;
  final Widget? overLoading;
  final Widget? bottomLoading;
  final String? errorMessage;
  final String retryButtonText;
  final String dismissText;
  final VoidCallback? onRetryPressed;
  final VoidCallback? onDismissPressed;
  final Widget child;
  final bool isFromMainScreens;

  const OverlayScreen({
    super.key,
    required this.isLoading,
    required this.child,
    this.progressIndicator,
    this.overLoading,
    this.bottomLoading,
    this.backgroundColor,
    this.errorMessage,
    this.retryButtonText = 'try_again',
    this.dismissText = 'dismiss',
    this.onRetryPressed,
    this.onDismissPressed,
    this.isFromMainScreens = false,
  });

  @override
  State<StatefulWidget> createState() {
    return _OverlayScreenState();
  }
}

class _OverlayScreenState extends State<OverlayScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Visibility(
            visible: widget.isLoading,
            child: Container(
                color:
                    widget.backgroundColor ?? Get.theme.scaffoldBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.overLoading != null) widget.overLoading!,
                    const SizedBox(height: padding20),
                    Center(
                        child: widget.errorMessage.validString
                            ? MyError(
                                errorMessage: widget.errorMessage!,
                                retryButtonText: widget.retryButtonText,
                                onRetryPressed: _retryCheck,
                                dismissText: widget.dismissText,
                                onDismissPressed: widget.onDismissPressed,
                              )
                            : (widget.progressIndicator ??
                                myWidget.defaultAppLoader())),
                    const SizedBox(height: padding20),
                    if (widget.bottomLoading != null) widget.bottomLoading!,
                  ],
                ))),
      ],
    );
  }

  /// check try again function is called from
  /// dashbaord, profile & transactions
  void Function()? get _retryCheck => widget.isFromMainScreens
      ? () => Get.find<HomeController>().tryAgain()
      : widget.onRetryPressed;
}
