import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_pin_put.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:tasty_choise_customer/future/auth/presentation/pages/reset_password_screen.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/main_screen.dart';

class VerificationAccountScreen extends StatefulWidget {
  final String email;
  final bool byForgetPasswordScreen;
  const VerificationAccountScreen(
      {required this.email, required this.byForgetPasswordScreen, super.key});

  @override
  State<VerificationAccountScreen> createState() =>
      _VerificationAccountScreenState();
}

class _VerificationAccountScreenState extends State<VerificationAccountScreen> {
  late final StopWatchTimer _stopWatchTimer;
  final TextEditingController _codeController = TextEditingController();
  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countDown);
    _stopWatchTimer.setPresetMinuteTime(1);
    _stopWatchTimer.setPresetSecondTime(12);

    _stopWatchTimer.onStartTimer();

    super.initState();
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.WHITE,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SvgPicture.asset(
            'assets/images/ic_forget_pass.svg',
            width: 200.r,
            height: 200.r,
          ),
          SizedBox(height: 16.h),
          Align(
            child: MyText(
              title: 'تم ارسال كود مكون من 4 ارقام الى  البريد الالكتروني',
              fontSize: 14,
              textAlign: TextAlign.center,
              color: AppColors.GRAY,
            ),
          ),
          Align(
            child: MyText(
              title: widget.email,
              fontSize: 14,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w300,
              color: AppColors.BLACK,
            ),
          ),
          SizedBox(height: 32.h),
          MyPinput(
            textEditingController: _codeController,
          ),
          SizedBox(height: 43.h),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthVerifySuccess) {
                AppHelpers.showSnackBar(context, message: state.message);
                if (widget.byForgetPasswordScreen) {
                  AppHelpers.navigationToPage(
                      context, ResetPasswordScreen(input: widget.email));
                } else {
                  AppHelpers.navigationToPageAndExitAll(
                      context, const MainScreen());
                }
              }
              if (state is AuthVerifyFailuer) {
                AppHelpers.showSnackBar(context,
                    message: state.message, error: true);
              }
            },
            builder: (context, state) {
              if (state is AuthVerifyLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return MyElevatedButton(
                title: 'تاكيد الكود',
                fontSize: 16,
                borderRaduis: 30,
                fontWeight: FontWeight.bold,
                onPressed: () {
                  AuthCubit.get(context).verifyCode(
                    widget.email,
                    _codeController.text,
                    saveData: !widget.byForgetPasswordScreen,
                  );
                },
              );
            },
          ),
          SizedBox(height: 20.h),
          StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: 0,
            builder: (context, snap) {
              final value = snap.data;
              final displayTime = value == null
                  ? ''
                  : StopWatchTimer.getDisplayTime(
                      value,
                      milliSecond: false,
                      hours: false,
                    );
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    title: 'الكود ينتهي خلال : ',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.TEXT_LIGHT,
                  ),
                  MyText(
                    title: displayTime,
                    color: AppColors.RED,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
