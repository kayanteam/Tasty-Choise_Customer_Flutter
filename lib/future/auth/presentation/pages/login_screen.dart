import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/components/my_text_field.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:tasty_choise_customer/future/auth/presentation/pages/forget_password_screen.dart';
import 'package:tasty_choise_customer/future/auth/presentation/pages/register_screen.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/main_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              SizedBox(height: 20.h),
              Image.asset(
                'assets/images/ic_logo.png',
                width: 130.w,
                height: 116.h,
              ),
              SizedBox(height: 16.h),
              Align(
                child: MyText(
                  title: 'اهلا بعودتك 👋',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 64.h),
              MyTextField(
                controller: _emailController,
                textHint: '',
                hintColor: AppColors.GRAY,
                labelText: 'البريد الالكتروني',
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 8.w),
                    const Icon(Icons.email),
                    SizedBox(width: 8.w),
                  ],
                ),
                validator: (p0) => AppHelpers.checkFillData(p0, context),
              ),
              SizedBox(height: 16.h),
              MyTextField(
                controller: _passwordController,
                textHint: '',
                labelText: 'كلمة المرور',
                fontSize: 14,
                hintColor: AppColors.GRAY,
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
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: GestureDetector(
                  onTap: () {
                    AppHelpers.navigationToPage(
                        context, ForgetPasswordScreen());
                  },
                  child: MyText(
                    title: 'نسيت كلمة المرور؟',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoginSuccess) {
                    AppHelpers.navigationToPageAndExitAll(
                        context, MainScreen());
                  }
                  if (state is AuthLoginFailuer) {
                    AppHelpers.showSnackBar(
                      context,
                      message: state.message,
                      error: true,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoginLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }
                  return MyElevatedButton(
                    title: 'تسجيل الدخول',
                    fontSize: 16,
                    borderRaduis: 30,
                    fontWeight: FontWeight.bold,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthCubit.get(context).login(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'لا يوجد لدي حساب بالتطبيق ، ',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.GRAY,
                    fontSize: 14.sp,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'إنشاء حساب',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => AppHelpers.navigationToPage(
                            context, const RegisterScreen()),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.BLACK,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
