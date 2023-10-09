import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';

class AppLoaderDialog {
  static show(BuildContext context, {bool barrierDismissible = false}) {
    AlertDialog alert = const AlertDialog(
      backgroundColor: AppColors.TRANSPARENT,
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      content: MyContainerShape(
        bgContainer: AppColors.TRANSPARENT,
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );

    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
