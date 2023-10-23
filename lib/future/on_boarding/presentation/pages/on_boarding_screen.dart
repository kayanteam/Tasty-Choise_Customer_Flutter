import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';
import 'package:tasty_choise_customer/future/auth/presentation/pages/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BASE_COLOR,
      body: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            end: 0,
            start: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/bg_splash.png',
              fit: BoxFit.cover,
            ),
          ),
          PositionedDirectional(
            top: 0,
            end: 0,
            start: 0,
            bottom: 300.h,
            child: Stack(
              children: [
                PositionedDirectional(
                  child: Align(
                    child: Image.asset(
                      'assets/images/ic_chef.png',
                    ),
                  ),
                ),
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  start: 0,
                  child: MyContainerShape(
                    height: 105.h,
                    bgContainer: AppColors.TRANSPARENT,
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        PositionedDirectional(
                          start: -200,
                          end: -200,
                          top: 0,
                          child: SizedBox(
                            child: SvgPicture.asset(
                              'assets/images/ic_circle.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PositionedDirectional(
                  bottom: 0,
                  end: -50,
                  child: Image.asset(
                    'assets/images/ic_klipartz.png',
                    width: 112.w,
                  ),
                ),
                PositionedDirectional(
                  bottom: 0,
                  start: -50,
                  child: Image.asset(
                    'assets/images/ic_thinly.png',
                    width: 112.w,
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            start: 0,
            top: MediaQuery.of(context).size.height - 300.h,
            child: MyContainerShape(
              height: 105.h,
              width: double.infinity,
              bgContainer: AppColors.WHITE,
              child: Column(
                children: [
                  MyText(
                    title: 'مرحبا بك في  Saving Station',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        PositionedDirectional(
                          end: 16.w,
                          start: 16.w,
                          bottom: MediaQuery.of(context).padding.bottom + 10.h,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MyElevatedButton(
                                title: 'هيا بنا',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                onPressed: () {
                                  AppHelpers.navigationReplacementToPage(
                                      context, LoginScreen());
                                },
                                borderRaduis: 30,
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                        PositionedDirectional(
                          top: 20,
                          end: -25,
                          child: SvgPicture.asset(
                            'assets/images/ic_beff.svg',
                            width: 60.r,
                          ),
                        ),
                        PositionedDirectional(
                          top: 20,
                          start: -10,
                          child: SvgPicture.asset(
                            'assets/images/ic_beff2.svg',
                            width: 40.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
