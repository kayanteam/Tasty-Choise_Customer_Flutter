import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/components/my_text_field.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:tasty_choise_customer/future/auth/presentation/pages/verification_account_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ForgetPasswordScreen({super.key});

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
              title: 'نسيت كلمة المرور',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: MyText(
                title:
                    'سنرسل لك كود تحقق يتكون من 4 أرقام ، قم بإدخال رقم الهاتف  حتى نرسل لك كود التحقق',
                fontSize: 14,
                textAlign: TextAlign.center,
                color: AppColors.GRAY,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Form(
            key: _formKey,
            child: MyTextField(
              controller: _emailController,
              textHint: '',
              hintColor: AppColors.GRAY,
              labelText: 'البريد الالكتروني',
              validator: (p0) => AppHelpers.checkFillData(p0, context),
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 8.w),
                  const Icon(Icons.email),
                  SizedBox(width: 8.w),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthForgetPassFailuer) {
                AppHelpers.showSnackBar(
                  context,
                  message: state.message,
                  error: true,
                );
              }
              if (state is AuthForgetPassSuccess) {
                AppHelpers.showSnackBar(
                  context,
                  message: state.message,
                );
                AppHelpers.navigationToPage(
                  context,
                  VerificationAccountScreen(
                    email: _emailController.text,
                    byForgetPasswordScreen: true,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthForgetPassLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return MyElevatedButton(
                title: 'ارسال',
                fontSize: 16,
                borderRaduis: 30,
                fontWeight: FontWeight.bold,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AuthCubit.get(context).forgetPassword(
                      _emailController.text.trim(),
                    );
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
