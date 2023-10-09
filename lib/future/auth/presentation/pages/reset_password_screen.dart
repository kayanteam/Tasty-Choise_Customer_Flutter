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
import 'package:tasty_choise_customer/future/auth/presentation/pages/login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String input;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ResetPasswordScreen({
    super.key,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.WHITE,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
                title: 'إعادة تعيين كلمة المرور',
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
                      'أدخل كلمة المرور الجديدة حاول أن تكون غير معقدة لتستطيع التسجيل بعدها بسهولة ..',
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  color: AppColors.GRAY,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            MyTextField(
              controller: _passwordController,
              textHint: '',
              labelText: 'كلمة المرور',
              fontSize: 14,
              hintColor: AppColors.GRAY,
              obscureText: true,
              maxLines: 1,
              obscureEnabled: true,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 8.w),
                  const Icon(Icons.lock),
                  SizedBox(width: 8.w),
                ],
              ),
              validator: (p0) => AppHelpers.checkFillData(p0, context),
            ),
            SizedBox(height: 16.h),
            MyTextField(
              controller: _passwordConfirmationController,
              textHint: '',
              labelText: 'تأكيد كلمة المرور',
              fontSize: 14,
              hintColor: AppColors.GRAY,
              maxLines: 1,
              obscureText: true,
              obscureEnabled: true,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 8.w),
                  const Icon(Icons.lock),
                  SizedBox(width: 8.w),
                ],
              ),
              validator: (p0) => AppHelpers.checkFillDataWithMatchPaawords(
                  p0, _passwordController.text.trim(), context),
            ),
            SizedBox(height: 30.h),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthResetPassFailuer) {
                  AppHelpers.showSnackBar(
                    context,
                    message: state.message,
                    error: true,
                  );
                }
                if (state is AuthResetPassSuccess) {
                  AppHelpers.showSnackBar(
                    context,
                    message: state.message,
                  );
                  AppHelpers.navigationToPage(context, LoginScreen());
                }
              },
              builder: (context, state) {
                if (state is AuthResetPassLoading) {
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
                      AuthCubit.get(context).resetPassword(
                        input,
                        _passwordController.text.trim(),
                        _passwordConfirmationController.text.trim(),
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
