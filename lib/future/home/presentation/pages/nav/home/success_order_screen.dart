import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:tasty_choise_customer/core/components/my_contianer_shape.dart';
import 'package:tasty_choise_customer/core/components/my_elevated_button.dart';
import 'package:tasty_choise_customer/core/components/my_text.dart';
import 'package:tasty_choise_customer/core/utils/app_colors.dart';
import 'package:tasty_choise_customer/core/utils/app_helpers.dart';

class SuccessOrderScreen extends StatelessWidget {
  const SuccessOrderScreen({super.key});

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
              'assets/images/ic_shape2.png',
            ),
          ),
          PositionedDirectional(
            end: 0,
            start: 0,
            top: 50.h,
            child: Image.asset(
              'assets/images/im_person.png',
            ),
          ),
          PositionedDirectional(
            bottom: 0.h,
            end: 0,
            start: 0,
            child: MyContainerShape(
              bgContainer: AppColors.TRANSPARENT,
              child: SafeArea(
                child: Column(
                  children: [
                    MyContainerShape(
                      borderRadius: 16,
                      marginStart: 16,
                      marginEnd: 16,
                      paddingHorizontal: 16,
                      paddingVertical: 24,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyText(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                title: 'تهانينا',
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          MyText(
                            title:
                                'لقد تم طلب الخدمة بنجاح سيتم ارسال الطلب الخاص بكم  في اقرب   في اقرب وقت ..',
                            fontWeight: FontWeight.w300,
                            color: AppColors.GRAY3,
                          ),
                          SizedBox(height: 32.h),
                          Row(
                            children: [
                              Expanded(
                                child: MyElevatedButton(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  borderRaduis: 11,
                                  title: 'الرئيسية',
                                  iconColor: AppColors.WHITE,
                                  iconPath: 'assets/images/ic_home2.svg',
                                  onPressed: () {
                                    AppHelpers
                                        .navigationToPageAndExitAllWithoutFirst(
                                            context);
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
