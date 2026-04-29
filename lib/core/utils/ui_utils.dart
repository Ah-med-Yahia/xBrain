import 'package:explaino/core/constants/app_text_constants.dart';
import 'package:explaino/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIUtils {
  static void showEasyLoading({String? status}) {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ripple;
    EasyLoading.instance.indicatorSize = 45.0;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.radius = 10.0;
    EasyLoading.instance.backgroundColor = AppColors.primary;
    EasyLoading.instance.indicatorColor = AppColors.white;
    EasyLoading.instance.textColor = AppColors.white;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: status ?? AppTextConstants.loading);
  }

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

  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? backGroundColor,
    Color? textColor,
  }) => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: textColor ?? AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: backGroundColor ?? AppColors.green,
    ),
  );
}
