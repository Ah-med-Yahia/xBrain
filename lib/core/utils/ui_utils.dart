import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIUtils {
  static void showEasyLoading({String? status}) {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ripple;
    EasyLoading.instance.indicatorSize = 45.0;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.radius = 10.0;
    // EasyLoading.instance.backgroundColor = AppColors.;
    // EasyLoading.instance.indicatorColor = AppColors.white;
    // EasyLoading.instance.textColor = AppColors.white;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    // EasyLoading.show(status:status?? UiConstants.loading);
  }

  // static void showLoading(BuildContext context) => showDialog(
  //   context: context,
  //   barrierDismissible: false,
  //   builder: (_) => PopScope(
  //     canPop: false,
  //     child: AlertDialog(
  //       backgroundColor: Colors.transparent,
  //       content: SizedBox(
  //         height: MediaQuery.sizeOf(context).height * 0.2,
  //         child: const Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [LoadingIndicator()],
  //         ),
  //       ),
  //     ),
  //   ),
  // );

  static void hideLoading(BuildContext context) => Navigator.of(context).pop();
  static void hideEasyLoading() => EasyLoading.dismiss();

  static void showMessage(
    String message, {
    required Color backGroundColor,
    required Color textColor,
  }) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: backGroundColor,
    textColor: textColor,
  );
}