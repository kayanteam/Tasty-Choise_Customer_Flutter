import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_choise_customer/core/components/my_app_bar.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/components/my_text_field.dart';
import 'package:tasty_choise_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/auth/models/user_model.dart';
import 'package:tasty_choise_customer/future/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print(AuthCubit.get(context).user!.toJson());
    AuthCubit.get(context).pathImage = AuthCubit.get(context).user!.image ?? "";
    _nameController.text = AuthCubit.get(context).user!.name ?? "";
    _emailController.text = AuthCubit.get(context).user!.email ?? "";
    _phoneController.text = AuthCubit.get(context).user!.phone ?? "";
    super.initState();
  }

  @override
  void deactivate() {
    AuthCubit.get(context).pickedImage = false;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const MyAppBar(
        backgroundColor: AppColors.TRANSPARENT,
        textColor: AppColors.WHITE,
        fontSize: 16,
        title: 'الملف الشخصي',
        fontWeight: FontWeight.w400,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 230.h,
            child: Stack(
              children: [
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  child: SvgPicture.asset(
                    'assets/images/bg_update_profile.svg',
                    fit: BoxFit.fill,
                  ),
                ),
                PositionedDirectional(
                  start: 0,
                  end: 0,
                  bottom: 0,
                  child: Align(
                    child: MyContainerShape(
                      width: 128.r,
                      paddingVertical: 2,
                      height: 128.r,
                      paddingHorizontal: 2,
                      enableShadow: true,
                      shadow: AppColors.BLACK.withOpacity(0.1),
                      borderRadius: 100,
                      alignment: AlignmentDirectional.centerStart,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/images/ic_shape.svg',
                            width: 62.r,
                          ),
                          Center(
                            child: BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthUpdateProfileImageFailuer) {
                                  AppHelpers.showSnackBar(context,
                                      message: state.message, error: true);
                                }
                                if (state is AuthUpdateProfileImageSuccess) {
                                  AppHelpers.showSnackBar(context,
                                      message: state.message);
                                }
                              },
                              builder: (context, state) {
                                return MyContainerShape(
                                  width: 118.r,
                                  height: 118.r,
                                  borderRadius: 100,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await AuthCubit.get(context)
                                          .updateProfileImage();
                                    },
                                    child: state
                                            is AuthUpdateProfileImageLoading
                                        ? const CircularProgressIndicator
                                            .adaptive()
                                        : AuthCubit.get(context).user != null &&
                                                AuthCubit.get(context)
                                                        .user!
                                                        .image !=
                                                    null
                                            ? Image.network(
                                                SharedPrefController()
                                                    .getImage()!,
                                                fit: BoxFit.cover,
                                              )
                                            : Icon(
                                                Icons.person,
                                                size: 50.r,
                                              ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  MyText(title: 'اسم المستخدم'),
                  SizedBox(height: 10.h),
                  MyTextField(
                    controller: _nameController,
                    textHint: '',
                    isBorder: true,
                    validator: (p0) => AppHelpers.checkFillData(p0, context),
                  ),
                  SizedBox(height: 12.h),
                  MyText(title: 'رقم الهاتف'),
                  SizedBox(height: 10.h),
                  MyTextField(
                    controller: _phoneController,
                    textHint: '',
                    isBorder: true,
                    validator: (p0) => AppHelpers.checkFillData(p0, context),
                  ),
                  SizedBox(height: 12.h),
                  MyText(title: 'البريد الالكتروني'),
                  SizedBox(height: 10.h),
                  MyTextField(
                    controller: _emailController,
                    textHint: '',
                    isBorder: true,
                    validator: (p0) => AppHelpers.checkFillData(p0, context),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthUpdateProfileFailuer) {
                  AppHelpers.showSnackBar(context,
                      message: state.message, error: true);
                }
                if (state is AuthUpdateProfileSuccess) {
                  AppHelpers.showSnackBar(
                    context,
                    message: state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthUpdateProfileLoading) {
                  return const CircularProgressIndicator.adaptive();
                }
                return MyElevatedButton(
                  title: 'حفظ التعديل',
                  borderRaduis: 50,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthCubit.get(context).updateProfileData(
                        UserModel(
                          phone: _phoneController.text.trim(),
                          email: _emailController.text.trim(),
                          name: _nameController.text.trim(),
                          image: AuthCubit.get(context).pickedImage
                              ? AuthCubit.get(context).pathImage
                              : null,
                        ),
                      );
                    }
                  },
                  background: AppColors.WHITE,
                  titleColor: AppColors.BLACK.withOpacity(.7),
                  borderColor: Color(0xffEEEEEE),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
          ],
        ),
      ),
    );
  }
}
