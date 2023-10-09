import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';

class MyPinput extends StatelessWidget {
  final TextEditingController? textEditingController;
  const MyPinput({super.key, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60.r,
      height: 60.r,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.WHITE2,
        border: Border.all(color: AppColors.BORDER, width: 2),
        borderRadius: BorderRadius.circular(50.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: AppColors.BASE_COLOR.withOpacity(.05),
      border: Border.all(color: AppColors.BASE_COLOR),
      borderRadius: BorderRadius.circular(50.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
        // decoration: defaultPinTheme.decoration.copyWith(
        //   color: Color.fromRGBO(234, 239, 243, 1),
        // ),
        );

    return Pinput(
      controller: textEditingController,
      pinAnimationType: PinAnimationType.fade,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }
}
