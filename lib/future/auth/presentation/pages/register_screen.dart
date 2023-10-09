import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/components/my_text_field.dart';
import 'package:tasty_choise_customer/core/components/terms_and_privacy_widget.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:tasty_choise_customer/future/auth/presentation/pages/verification_account_screen.dart';
import 'package:tasty_choise_customer/future/home/presentation/manager/home_cubit/home_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void deactivate() {
    AuthCubit.get(context).agreeTerms = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is LoadingData) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            return Form(
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
                      title: 'حساب جديد',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 64.h),
                  MyTextField(
                    controller: _nameController,
                    textHint: '',
                    hintColor: AppColors.GRAY,
                    labelText: 'اسم المستخدم',
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 8.w),
                        const Icon(Icons.person),
                        SizedBox(width: 8.w),
                      ],
                    ),
                    validator: (p0) => AppHelpers.checkFillData(p0, context),
                  ),
                  SizedBox(height: 16.h),
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
                    controller: _passController,
                    textHint: '',
                    hintColor: AppColors.GRAY,
                    labelText: 'كلمة المرور',
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 8.w),
                        const Icon(Icons.password),
                        SizedBox(width: 8.w),
                      ],
                    ),
                    validator: (p0) => AppHelpers.checkFillData(p0, context),
                  ),
                  SizedBox(height: 20.h),
                  const TermsAndPrivacyPolicyWidget(),
                  SizedBox(height: 30.h),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthRegisterSuccess) {
                        AppHelpers.navigationToPageAndExitAll(
                          context,
                          VerificationAccountScreen(
                            email: _emailController.text,
                            byForgetPasswordScreen: false,
                          ),
                        );
                      }
                      if (state is AuthRegisterFailuer) {
                        AppHelpers.showSnackBar(
                          context,
                          message: state.message,
                          error: true,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthRegisterLoading) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      return MyElevatedButton(
                        title: 'انشاء حساب',
                        fontSize: 16,
                        borderRaduis: 30,
                        fontWeight: FontWeight.bold,
                        onPressed: AuthCubit.get(context).agreeTerms
                            ? () async {
                                if (_formKey.currentState!.validate()) {
                                  await AuthCubit.get(context).register(
                                    email: _emailController.text.trim(),
                                    password: _passController.text.trim(),
                                    name: _nameController.text.trim(),
                                  );
                                }
                              }
                            : null,
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'لدي بالفعل حساب ، ',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: AppColors.GRAY,
                        fontSize: 14.sp,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'تسجيل دخول',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => AppHelpers.navigationBack(context),
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
            );
          },
        ),
      ),
    );
  }
}
