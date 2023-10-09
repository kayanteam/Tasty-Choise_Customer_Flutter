import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/storage/pref/shared_pref_controller.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/auth/presentation/pages/login_screen.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/profile/about_us_screen.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/profile/privacy_policy_screen.dart';
import 'package:tasty_choise_customer/future/home/presentation/pages/nav/profile/update_profile_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PositionedDirectional(
          top: 0,
          end: 0,
          start: 0,
          bottom: 0,
          child: Container(
            color: AppColors.BASE_COLOR,
            child: Image.asset(
              'assets/images/bg_splash.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        PositionedDirectional(
          top: 0,
          end: 0,
          start: 0,
          bottom: 0,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SafeArea(
                      child: Image.asset(
                        'assets/images/ic_logo2.png',
                        width: 143.r,
                        height: 128.r,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: MyContainerShape(
                  topEndRaduis: 34,
                  topStartRaduis: 34,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 24.h),
                          children: [
                            ItemDrawer(
                              icon: 'assets/images/settings/ic_profile2.svg',
                              title: 'الملف الشخصي',
                              onTap: () {
                                AppHelpers.navigationToPage(
                                    context, UpdateProfileScreen());
                              },
                            ),
                            ItemDrawer(
                              icon: 'assets/images/settings/ic_settings2.svg',
                              title: 'تغير كلمة المرور',
                              onTap: () {},
                            ),
                            ItemDrawer(
                              icon:
                                  'assets/images/settings/ic_privacy_policy.svg',
                              title: 'سياسة الخصوصية',
                              onTap: () {
                                AppHelpers.navigationToPage(
                                    context, const PrivacyPolicyScreen());
                              },
                            ),
                            ItemDrawer(
                              icon: 'assets/images/settings/ic_about_us.svg',
                              title: 'عن التطبيق',
                              onTap: () {
                                AppHelpers.navigationToPage(
                                    context, const AboutUsScreen());
                              },
                            ),
                            ItemDrawer(
                              icon: 'assets/images/settings/ic_delete.svg',
                              title: 'حذف الحساب',
                              onTap: () {},
                            ),
                            ItemDrawer(
                              icon: 'assets/images/settings/ic_logoutt.svg',
                              title: 'تسجيل خروج',
                              onTap: () async {
                                await SharedPrefController().clearAllData();
                                AppHelpers.navigationToPageAndExitAll(
                                    context, LoginScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/ic_social/ic_instgram.svg',
                            color: AppColors.GRAY2,
                          ),
                          SizedBox(width: 26.w),
                          SvgPicture.asset(
                            'assets/images/ic_social/ic_ticktok.svg',
                            color: AppColors.GRAY2,
                          ),
                          SizedBox(width: 26.w),
                          SvgPicture.asset(
                            'assets/images/ic_social/ic_twitter.svg',
                            color: AppColors.GRAY2,
                          ),
                          SizedBox(width: 26.w),
                          SvgPicture.asset(
                            'assets/images/ic_social/ic_whats.svg',
                            color: AppColors.GRAY2,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ItemDrawer extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onTap;

  const ItemDrawer({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 56.h,
            child: Row(
              children: [
                SizedBox(width: 16.w),
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: SvgPicture.asset(
                    icon,
                    width: 24.r,
                    height: 24.r,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: MyText(
                    title: title,
                    fontSize: 12,
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/ic_arrow.svg',
                ),
                SizedBox(width: 16.w),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
